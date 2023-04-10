# Ruby

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This repository contains a collection of Ruby programs and scripts.

## Table of Contents
- [What is Ruby](#what-is-ruby)   
- [Installation](#installation)
  - [Installing Ruby](#installing-ruby)    
    - [Windows](#windows)
    - [Linux](#linux)
    - [macOS](#macOS)  
  - [Installing Repository](#installing-repository)  
- [Usage](#usage)
  - [Running Ruby Programs](#running-ruby-programs)
  - [Using Bundler](#using-bundler)
- [Contributing](#contributing)
- [License](#license)

## What is Rust

Ruby is a dynamic, object-oriented programming language that is popular among developers for its simplicity and productivity. It was created in the mid-1990s by Yukihiro Matsumoto, and is known for its elegant syntax and expressive nature.

Ruby is a high-level language, meaning that it abstracts away many low-level details like memory management and type declarations. This makes it easy to write code quickly and to read and understand other people's code. Ruby is also dynamically typed, meaning that the types of variables and expressions are determined at runtime rather than compile time.

Ruby has a powerful standard library, and a vibrant ecosystem of third-party libraries and tools, which makes it easy to accomplish many common programming tasks. It is often used for web development, especially with the popular Ruby on Rails framework, as well as for scripting and automation, game development, and more.

## Installation

### Installing Ruby

These are the general steps to install Ruby on different platforms. However, the exact steps may vary depending on the specific operating system and version you are using. It's always a good idea to refer to the official documentation for your platform to get more detailed installation instructions.

#### Windows

1. Download the Ruby installation executable from the official Rust website.
2. Run the downloaded file and follow the installation instructions.
3. Once the installation is complete, you can use any text editor or IDE (Integrated Development Environment) to write and compile Rust code.

#### Linux

1. Install Rust using the package manager for your Linux distribution. For example, on Ubuntu, you can use the following command:

```
sudo apt-get install ruby
```

2. Once Ruby is installed, you can use any text editor or IDE to write and compile Rust code.

#### macOS

1. macOS comes with Ruby pre-installed. However, you may want to install a more recent version of Ruby. The easiest way to do this is to use a package manager like Homebrew. Open a terminal and run the following command:

```
brew install ruby
```

2. Once Ruby is installed, you can use any text editor or IDE to write and compile Rust code.

Alternatively, you can also download the Ruby installation package for macOS from the official Ruby website and follow the installation instructions.

### Installing Repository

You can download individual files, copy & paste code, or clone the repository

```
git clone https://github.com/Eggy115/Ruby.git
```
      
## Usage

### Running Ruby Programs

1. Clone the repository. If you have written your own programs, save the program with a `.rb` file extension.
2. Open a terminal or command prompt and navigate to the directory where the Ruby program is saved.
3. Run the following command to run the Ruby program:

```
ruby program_name.rb
```

Replace program_name with the name of your Ruby program.
This will execute your Ruby program.


### Bundler

Alternatively, you can use Bundler, Ruby's built-in package manager and dependency manager, to manage dependencies and run your Ruby program. Here are the steps:

1. Create a new Ruby project using Bundler by running the following command in a terminal:

```
bundle init
```

This will create a `Gemfile` in your current directory.

2. Open the Gemfile and add any dependencies that your Ruby program requires. For example:

```
source "https://rubygems.org"
gem "httparty"
```

This will add the httparty gem to your project.

3. Install the dependencies by running the following command in a terminal:

```
bundle install
```

This will install any dependencies specified in your Gemfile.

4. Write your Ruby program and save it with a `.rb` file extension.
5. Use Bundler to run your program by running the following command in a terminal:

```
bundle exec ruby program_name.rb
```

This will execute your Ruby program with the dependencies specified in your Gemfile.

## Contributing

Contributions are always welcome! Follow these steps to contribute:

1. Fork the repository and make your changes. 
2. Submit a pull request with your changes.
3. Create an issue if you find a bug or have a feature request.

Please make sure to adhere to the [code of conduct](CODE_OF_CONDUCT.md) and the [contributing guidelines](CONTRIBUTING.md).

## License

This repository is licensed under the [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.html). See the [LICENSE](LICENSE) file for more information.
