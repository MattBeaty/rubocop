# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      # This cop checks for *return* from an *ensure* block.
      # Explicit return from an ensure block alters the control flow
      # as the return will take precedence over any exception being raised,
      # and the exception will be silently thrown away as if it were rescued.
      #
      # @example
      #
      #   # bad
      #
      #   begin
      #     do_something
      #   ensure
      #     do_something_else
      #     return
      #   end
      #
      # @example
      #
      #   # good
      #
      #   begin
      #     do_something
      #   ensure
      #     do_something_else
      #   end
      class EnsureReturn < Cop
        MSG = 'Do not return from an `ensure` block.'

        def on_ensure(node)
          ensure_body = node.body

          return unless ensure_body

          ensure_body.each_node(:return) do |return_node|
            add_offense(return_node)
          end
        end
      end
    end
  end
end
