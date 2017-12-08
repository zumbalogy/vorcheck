# VorCheck

This repo is the basis for our engineering quiz, which is part of our standard
interview process. It's important to understand that we don't use programming
excercises as a discrete _pass_ or _fail_ tool. We use these excercises as a
starting point for coding-focused conversations. These conversations help us
better understand a potential candidate's skill levels.

## How to Use

  1. Fork this repo into your own github account
  1. Work on it for about an hour (a little more-or-less is fine
  as we aren't tracking time, we just don't feel it's necessary
  to work on it any longer than an hour)
  1. When you are finished, provide us with a copy of your
  work (this could be a pull-request, or just a pointer
  to your repo)
  
## Excercises

There are empty directories in this repo, and work should be done
entirely within them. This is just to keep everything in one place.

### Rails

**Language: Rails (i.e., Ruby)**

In the `url-shortener` directory, build a URL shortener with Rails.

### Object Oriented Programming

**Language: Any language that supports object-oriented design**

In the `object-oriented` directory, implement **one** of the following...

  - A `PhoneNumber` class, that provides a reasonable API around the concept of
    a phone number
  - A `Grade` class that implements a reasonable API for grades that look like
    the letter grading system (i.e., A+, A, A-, B+, B, ...)

One requirement of these classes is they serialize and deserialize to
a regular string (varchar) in order to persist to a database.

### Algorithm

**Language: Any language**

In the `longest-substring` directory, implement an algorithm that when
given a string, returns the longest repeating substring found in the input.
E.g., in the string "phenomenal", the longest repeating substring is "en".

