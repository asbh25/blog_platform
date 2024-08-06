# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      def authorize(record, query = nil, **policy_class)
        super
      end
    end
  end
end
