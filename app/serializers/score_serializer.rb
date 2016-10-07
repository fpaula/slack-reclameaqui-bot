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
            color: color,
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
            "image_url": "#{ENV['DEFAULT_HOST']}/images/#{object.status.downcase}.png",
            "thumb_url": "#{ENV['DEFAULT_HOST']}/images/#{object.status.downcase}.png",
            "footer": "Youse Bot",
            "footer_icon": ENV['LOGO_URL'],
            "ts": Time.zone.now.to_i
        }
    ]
  end

  def color
    {
      great: '#36a64f',
      no_index: '#a7a7a7',
      not_recommended: '#8d549f',
      bad: '#e92526',
      regular: '#ebb322',
      good: '#415ba9',
      ra1000: '#009448'
    }[object.status.downcase.to_sym]
  end
end
