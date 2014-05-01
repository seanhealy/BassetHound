@APP = angular.module('resume', [])
@APP.config ($interpolateProvider) ->
	$interpolateProvider.startSymbol('<:')
	$interpolateProvider.endSymbol(':>')

@ResumeController = ($scope, $filter, $http) ->
	$scope.experience = ResumeData.experience
	$scope.profile = ResumeData.profile
	
	$scope.shortName = (item) ->
		return item.shortName if item.shortName?
		return item.name
	
	$scope.predicate = "to"
	$scope.reverse = true
	
	$scope.tagPredicate = 'tag'
	
	$scope.byDate = ->
		if $scope.predicate is 'to'
			$scope.reverse = !$scope.reverse
		else
			$scope.predicate = 'to'
			$scope.reverse = true
	
	$scope.currentSection = -1
	$scope.setCurrentSection = (section) ->
		$scope.currentSection = section
	$scope.isCurrentSection = (section) ->
		$scope.currentSection is section

window.addEventListener 'load', ->
	setTimeout ->
			bird = document.getElementById 'flight_ring_bird'
			bird.classList.add 'fly'
	, 750

$ ->
	$('.navigation a').smoothScroll speed: 300
	
	$scope = angular.element(document.getElementsByClassName('content')[0]).scope()
	currentSection = window.location.hash.match(/#\D+(\d+)/)?[1]
	
	$scope.$apply ->
		$scope.currentSection = parseInt(currentSection) if currentSection?
