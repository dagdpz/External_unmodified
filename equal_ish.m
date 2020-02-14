function equal_or_not = equal_ish(testValue1,testValue2)
if isnan(testValue1) && isnan(testValue2)
   equal_or_not = true;
else
subtraction_abs = abs(testValue1 - testValue2);
equal_or_not = (subtraction_abs <= eps(testValue1)) && (subtraction_abs <= eps(testValue2));    
end