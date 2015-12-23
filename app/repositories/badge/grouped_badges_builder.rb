module GroupedBadgesBuilder

  # creates Badges putting it in a structure like the one below
  #
  # {:tip=>
  #   {
  #    "tip_badge#correct"=>
  #     [
  #      #<TipBadge:0x007f81706261e8 @achievement=1, @color="bronze", @icon="fa-bullseye", @result="correct", @score=10>,
  #      #<TipBadge:0x007f8170625fb8 @achievement=5, @color="silver", @icon="fa-bullseye", @result="correct", @score=20>,
  #      #<TipBadge:0x007f8170625d38 @achievement=10, @color="gold", @icon="fa-bullseye", @result="correct", @score=30>,
  #      #<TipBadge:0x007f8170625b08 @achievement=15, @color="platinum", @icon="fa-bullseye", @result="correct", @score=15>
  #     ],
  #    "tip_consecutive_badge#correct"=>
  #     [
  #      #<TipConsecutiveBadge:0x007f81706258b0 @achievement=2, @color="bronze", @icon="fa-rocket", @result="correct", @score=11>,
  #      #<TipConsecutiveBadge:0x007f8170625680 @achievement=3, @color="silver", @icon="fa-rocket", @result="correct", @score=16>,
  #      #<TipConsecutiveBadge:0x007f8170625450 @achievement=4, @color="gold", @icon="fa-rocket", @result="correct", @score=16>,
  #      #<TipConsecutiveBadge:0x007f81706251d0 @achievement=5, @color="plantinum", @icon="fa-rocket", @result="correct", @score=16>
  #     ]
  #   },
  #  :comment=>
  #   {
  #    "comment_created_badge"=>
  #     [
  #      #<CommentCreatedBadge:0x007f8170614218 @achievement=1, @color="bronze", @icon="fa-comments-o", @score=5>,
  #      #<CommentCreatedBadge:0x007f8169d4a458 @achievement=4, @color="silver", @icon="fa-comments-o", @score=6>,
  #      #<CommentCreatedBadge:0x007f8169d4a110 @achievement=8, @color="gold", @icon="fa-comments-o", @score=10>},
  #     ],
  #    "comment_consecutive_created_badge"=>
  #     [
  #      #<CommentConsecutiveCreatedBadge:0x007f8169d1e5d8 @achievement=3, @color="bronze", @icon="fa-bullhorn", @score=2>,
  #      #<CommentConsecutiveCreatedBadge:0x007f8169d1c6e8 @achievement=4, @color="silver", @icon="fa-bullhorn", @score=3>,
  #      #<CommentConsecutiveCreatedBadge:0x007f8169d1c508 @achievement=5, @color="gold", @icon="fa-bullhorn", @score=4>
  #     ]
  #   }
  # }

  class << self

    def build grouped_badges_description

      grouped_badges = {}

      grouped_badges_description.keys.each do |group|

        grouped_badges[group] = {}

        BadgesBuilder.build(grouped_badges_description[group]).each do |badge|
          grouped_badges[group][badge.group_identifier] = [] unless grouped_badges[group].key? badge.group_identifier
          grouped_badges[group][badge.group_identifier] << badge
        end
      end

      sort_badges_by_score grouped_badges
    end

    private

    def sort_badges_by_score grouped_badges

      grouped_badges.each do |group, group_identifiers|
        group_identifiers.keys.each do |group_identifier|
          grouped_badges[group][group_identifier].sort_by! { |badge| badge.score }
        end
      end

      grouped_badges
    end
  end
end