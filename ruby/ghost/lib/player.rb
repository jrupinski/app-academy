# Player class
class Player
    class alert_invalid_guess < StandardError
        def message
            "Guess invalid!"
        end
    end

    def initialize(name)
        @name = name
    end

    def guess
        # todo
    end
end