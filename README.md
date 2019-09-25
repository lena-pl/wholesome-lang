# wholesome-lang
A silly language for wholesome software fun.

## Usage
* assignment
You can now assign values to variables.
Eg. `name = "Wholesome Lang"`
You can see this function in usage in `samples/psst.wl`

* `psst` (analogous to Ruby's `print`)
This function takes the string to be printed as a parameter.
Eg. `psst "Hello, world!"`
The sample file for this function can be found in `samples/psst.wl`

## Running a .wl file
At the moment, these files must run via `wholesome-lang.rb`
In order to execute a wl file, you must pass its filepath as the last argument when
executing wholesome-lang.rb
Eg. `ruby wholesome-lang.rb samples/psst.wl`

## Debugging
When executing `wholesome-lang.rb`, you have the option to pass the following flags:


`--failure-rate` executes the wl file 100 times, logging the parsing process each time; reports pass/fails stats

`--dump-source` prints the source code after executing the wl file

`--dump-tokens` prints the tokens stream before executing the wl file

`--dump-tree` steps through every node via parser, calling `debug_print` before executing the wl file

`--dump-context` prints the variables from source after executing the wl file

## Credits and Licensing
This project is licensed under the MIT License. You can find the license file in the repo.

In order to keep this language as wholesome as possible, RUDE words cause an exception at runtime.
This functionality is enabled by the [List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words](https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words) project, licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/) license.
