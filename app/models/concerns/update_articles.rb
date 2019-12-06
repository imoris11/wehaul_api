module UpdateArticles
    extend ActiveSupport::Concern

    included do
        after_create :update_count
        before_destroy :reduce_count
    end

    protected

    def update_count
        articles = self.user.num_of_articles
        self.user.update({num_of_articles: articles+1})
    end

    def reduce_count
        articles = self.user.num_of_articles
        self.user.update({num_of_articles: articles-1})
    end
    
end