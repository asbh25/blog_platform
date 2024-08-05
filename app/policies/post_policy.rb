# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.present?
    end

    alias update? create?
  end
end
