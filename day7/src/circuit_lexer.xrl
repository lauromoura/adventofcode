Definitions.

NUMBER       = [0-9]+
IDENTIFIER = [a-z]+
WHITESPACE = [\s\t\n\r]+


Rules.

{NUMBER}            : {token, {number,  TokenLine, list_to_integer(TokenChars)}}.
{IDENTIFIER}        : {token, {identifier, TokenLine, list_to_atom(TokenChars)}}.
NOT                 : {token, {unaryop, TokenLine, list_to_atom(TokenChars)}}.
AND|OR              : {token, {binaryop, TokenLine, list_to_atom(TokenChars)}}.
[R|L]SHIFT          : {token, {shiftop, TokenLine, list_to_atom(TokenChars)}}.
\-\>                : {token, {'->', TokenLine}}.
{WHITESPACE}+       : skip_token.

Erlang code.
