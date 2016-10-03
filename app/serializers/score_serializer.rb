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
        title: 'Não atendidas',
        text: object.total_not_answered
      },
      {
        title: 'Reclamações',
        text: object.total_complains
      },
      {
        title: 'Nota do consumidor',
        text: object.consumer_score
      },
      {
        title: 'Índice de solução',
        text: "#{object.solved_percentual}%"
      },
      {
        title: 'Respondidas',
        text: object.total_answered
      },
      {
        title: 'Avaliações',
        text: object.total_evaluated
      },
      {
        title: 'Índice de respostas',
        text: "#{object.answered_percentual}%"
      },
      {
        title: 'Fariam negócio novamente',
        text: "#{object.deal_again_percentual}%"
      }
    ]
  end
end
