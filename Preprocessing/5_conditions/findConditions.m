function res = findConditions(first, last, target, events_to_extract)
res = {};
    for i = first : last
        if startsWith(events_to_extract{i},target)
            res = [res; events_to_extract{i}];
        end
    end
end