function output = normalize(input, range)

output = (range(2) - range(1)) .* input + range(1);

end