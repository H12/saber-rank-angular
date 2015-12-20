var app = angular.module('saberRank', []);

app.controller('BattersController', ['$scope', 'batters', function($scope, batters) {
  batters.success(function(data) {
    $scope.batters = data;
  });
}]);

app.factory('batters', ['$http', function($http) {
  batters = $http.get('/batters')
    .success(function(data) {
      return data;
    })
    .error(function(err) {
      return err;
    });

  return batters;
}]);