#!/bin/bash

input=$1
if [ $input = "live" ]
then
    echo "Live Test"
    url="https://i8y1ne9l3b.execute-api.ap-northeast-2.amazonaws.com/default/random-letter"
else
    echo "Local Test"
    url="http://localhost:9000/2015-03-31/functions/function/invocations"
fi

echo -e "url: ${url}"

echo -e "\nno api_key"
curl -XPOST $url -d '{}'

echo -e "\nno cmd"
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"api_key" : "D!BGCJH#6K@jnS@F"}'

echo -e "\n\npython3"
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"cmd": "python3", "code" : "print(1+1)", "api_key" : "D!BGCJH#6K@jnS@F"}'

echo -e "\n\nnode"
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"cmd": "node", "code" : "console.log(1+1)", "api_key" : "D!BGCJH#6K@jnS@F"}'

echo -e "\n\ngcc"
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"cmd": "gcc", "code" : "#include <stdio.h>\nint main() { printf(\"HelloC\");}\n", "api_key" : "D!BGCJH#6K@jnS@F"}'

echo -e "\n\ng++"
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"cmd": "g++", "code" : "#include <iostream>\nint main() { std::cout << \"HelloC++\" << std::endl;}\n", "api_key" : "D!BGCJH#6K@jnS@F"}'

echo -e "\n"
