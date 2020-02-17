$LOAD_PATH << './src'
$LOAD_PATH << './src/tokens'

require 'token'
require 'identifier_token'
require 'literal_token'
require 'assignment_token'

require 'parser'
require 'tokeniser'
require 'context'
