#README

##Description

Saber Rank is a simple ranking application that evaluates baseball players on their ability to get specific statistics. The idea is that this would be useful for fantasy baseball leagues that use head-to-head scoring.

##Methodology

Stats are normalized on a scale from 0 to 1, where 0 is the lowest value of a stat, and 1 is the highest. Then, all normalized stats are summed to determine 'STAT', which is a number out of the number of tracked stats (e.g. if there are 6 tats tracked and normalized ) that represents how good a player is at getting the specified statistics.

##Purpose

The overlying purpose of this app is for me to get a bit of practice with front-end frameworks. This is the Angular version.