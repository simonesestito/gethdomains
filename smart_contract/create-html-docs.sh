#!/bin/sh --
set -e

npm install

# Generate Markdown docs
npx hardhat docgen

# Create the HTML page step-by-step
# Add the head
cat << EOF > docs/index.html
<html>
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/highlightjs@9.16.2/styles/atom-one-dark.css" rel="stylesheet">
        <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #282C34;
            color: #f0f0f0;
        }
        </style>
    </head>
    <body>
EOF

# Add the HTML conversion of the Markdown docs
npx marked docs/index.md >> docs/index.html

# Add the rest of the body, including the highlight of the code
cat << EOF >> docs/index.html
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/highlightjs@9.16.2/highlight.pack.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/highlightjs-solidity@2.0.6/dist/solidity.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/highlightjs-solidity@2.0.6/dist/yul.min.js"></script>
        <script type="text/javascript">
            hljs.initHighlightingOnLoad();
            document.querySelectorAll('code.language-solidity').forEach(codeElem => {
                // codeElem.innerHTML = 
            });
        </script>
    </body>
</html>
EOF
