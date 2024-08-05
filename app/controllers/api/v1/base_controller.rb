# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController

      def policy_scope(scope)
        super(scope)
      end

      def authorize(record, query = nil, **policy_class)
        super(record, query, **policy_class)
      end

    end
  end
end
