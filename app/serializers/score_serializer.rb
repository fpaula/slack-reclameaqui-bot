class ScoreSerializer < ActiveModel::Serializer
  attribute :attachments

  attribute :response_type do
    'ephemeral'
  end

  attribute :text do
    "O Status atual é `#{I18n.t object.status.downcase}`"
  end

  def attachments
    [
        {
            color: "#36a64f",
            fields: [
                {
                  title: 'Não atendidas',
                  value: object.total_not_answered
                },
                {
                  title: 'Reclamações',
                  value: object.total_complains
                },
                {
                  title: 'Nota do consumidor',
                  value: object.consumer_score
                },
                {
                  title: 'Índice de solução',
                  value: "#{object.solved_percentual}%"
                },
                {
                  title: 'Respondidas',
                  value: object.total_answered
                },
                {
                  title: 'Avaliações',
                  value: object.total_evaluated
                },
                {
                  title: 'Índice de respostas',
                  value: "#{object.answered_percentual}%"
                },
                {
                  title: 'Fariam negócio novamente',
                  value: "#{object.deal_again_percentual}%"
                }
            ],
            "image_url": "https://slack-reclameaqui-bot.herokuapp.com/images/#{object.status.downcase}.png",
            "thumb_url": "https://slack-reclameaqui-bot.herokuapp.com/images/#{object.status.downcase}.png",
            "footer": "Youse Bot",
            "footer_icon": "https://slack-reclameaqui-bot.herokuapp.com/images/logo_youse.png",
            "ts": 123456789
        }
    ]
  end
end

#TODO: teste https://api.slack.com/docs/messages/builder
