function [slopes,intercepts,line] = estimate_line(slopes,intercepts,slope,intercept,n)

if length(slopes)>n
    slopes(1)=[];
    intercepts(1)=[];
end
if (abs(mean(slopes)-slope)>0.1) | (abs(mean(intercepts)-intercept)>10)
    line = [mean(slopes), mean(intercepts)];
    if (abs(mean(slopes)-slope)<1) | (abs(mean(intercepts)-intercept)<100)
            slopes = [slopes, slope];
            intercepts = [intercepts, intercept];
    end
else
    slopes = [slopes, slope];
    intercepts = [intercepts, intercept];
    line = [mean(slopes), mean(intercepts)];
end
end