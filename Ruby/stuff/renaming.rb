# make the method more descriptive
def return_number(a)
    ((a / 2)**2) * (65 - (a / 2))
end

# more descriptive version
def child_retirement_budget(your_age)
    child_age = your_age / 2
    retirement_age = 65
    years_until_retirement =retirement_age - child_age
    childs_current_budget = child_age ** 2

    childs_current_budget * years_until_retirement
end

