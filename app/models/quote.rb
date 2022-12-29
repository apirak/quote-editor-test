class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend

  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }

  # after_create_commit lambda {
  #                       broadcast_prepend_to "quotes",
  #                                            partial: "quotes/quote",
  #                                            locals: {
  #                                              quote: self,
  #                                            },
  #                                            target: "quotes"
  #                     }
end

# broadcast_prepend_to(*streamables, target: broadcast_target_default, **rendering)

# Sends
# <turbo-stream action="prepend" target="clearances">
#  <template>
#   <div id="clearance_5">My Clearance</div>
#  </template>
# </turbo-stream>
# to the stream named "identity:2:clearances"
# clearance.broadcast_prepend_to examiner.identity, :clearances, target: "clearances"

# Sends
# <turbo-stream action="prepend" target="clearances">
#   <template>
#     <div id="clearance_5">Other partial</div>
#   </template>
# </turbo-stream>
# to the stream named "identity:2:clearances"
# clearance.broadcast_prepend_to examiner.identity, :clearances, target: "clearances",
#   partial: "clearances/other_partial", locals: { a: 1 }
