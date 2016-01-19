var app = angular.module('saberRank', []);

app.controller('BattersController', ['$scope', 'batters', function($scope, batters) {
  batters.success(function(data) {
    $scope.sortType = 'stat';
    $scope.sortDesc = true;
    $scope.changeSortType = function(statName) {
      $scope.sortType = statName;
    };
    $scope.changeSortDesc = function(column) {
      if ($scope.sortType == column) {
        $scope.sortDesc = !$scope.sortDesc
      }
    };
    $scope.log = function(stats) {
      console.log(stats);
    };
    $scope.stats = ['avg','hr','r','rbi','sb','slg','obp','ops','so','singles','doubles','triples','ab','bb','cs','gdp','h','hbp','ibb','pitches','pa','sf','sh','tb','ppa','rc','sbn','sac','xba']
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