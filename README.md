ggp2
====

[![Build Status](https://travis-ci.org/gramie-sw/ggp2.png?branch=master)](https://travis-ci.org/gramie-sw/ggp2)
[![Code Climate](https://codeclimate.com/github/gramie-sw/ggp2.png)](https://codeclimate.com/github/gramie-sw/ggp2)

Game Guessing Portal 2
----------------------

Functionally ggp2 is a Rails based prediction game for soccer championships. Pit your strength against your comrades and
earn badges and fame by guessing the winner of each match and predicting the upcoming champion team.

Technically ggp2 acts a showcase and is used to investigate the feasibility of transforming a standard Rails application
into a Domain-Driven software project.

Originally inspired by Uncle Bob's video ["Architecture the lost years"](http://www.youtube.com/watch?v=WpkDN78P884)
but with a lack of real world examples, we are testing different solutions in order to establish more explicit
boundaries between the layers of an application. The main goal is a clear separation of the delivery mechanism and the
data layer from the business code, in order to reduce it's dependency from Rails.

Being well aware that the over-praised “Rails Way” stands in an obvious contrast to the described efforts, we know by
experience that a growing Rails App can lead quickly to a mix of technical details and business related code that is
difficult to test.

We don't want to abandon Rails completely but our main attention should be directed to our business code, not to Rails.

This causes some basic architectural principles being used to transform ggp2 step-by-step:

* Write Use-Cases, that are to be visible in business code
* Controllers are part of the delivery mechanism, not of the business code
* Create a boundary to the data layer as good as possible (by the way the most difficult intend caused by the nature of ActiveRecord)


