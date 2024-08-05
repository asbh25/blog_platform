# frozen_string_literal: true

module Posts
  class List < ::PaginatedList

    def self.call(params)
      new(params).call
    end

    def call
      {
        posts: PostSerializer.render_as_hash(resources),
        pagination: build_pagination
      }
    end

    private

    attr_reader :params

    def initialize(params)
      @params = params.except(:page, :per_page)

      super(page: params[:page], per_page: (params[:per_page] || Post.default_per_page).to_i)
    end

    def resources
      @resources ||= Post.filter(params).includes(:user).order(created_at: :desc).page(page_number).per(per_page)
    end
  end
end
