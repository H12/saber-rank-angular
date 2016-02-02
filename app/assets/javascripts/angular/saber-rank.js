var app = angular.module('saberRank', []);

app.controller('BattersController', ['$scope', '$http', 'batters', function($scope, $http, batters) {
  batters.success(function(data) {
    $scope.batters = data;
  });
  $scope.minPa = 500;
  $scope.stats = ['avg','hr','r','rbi','sb','slg','obp','ops','so','singles','doubles','triples','ab','bb','cs','gdp','h','hbp','ibb','pitches','pa','sf','sh','tb','ppa','rc','sbn','sac','xbh']
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
  $scope.updateBatters = function(data) {
    var selectedStats = [];
    $('#selected option').each(function() {
      selectedStats.push($(this).val());
    });
    if (selectedStats.length > 15) {
      alert("Please select 15 or fewer stats.");
      $scope.removeOptions();
      $scope.sortStatOptions("#available");
    } else {
      $http({
        method: 'GET',
        url: '/batters',
        params: {stats: JSON.stringify(selectedStats), min_pa: JSON.stringify($scope.minPa)}
      })
      .success(function(data) {
        $scope.batters = data;
      })
      .error(function(err) {
        return err;
      });
    }
  };
  $scope.addOptions = function() {
    var optionsToAdd = $("#available").find("option:selected");
    for (var i = 0; i < optionsToAdd.length; i++) {
      $("#selected select").append(optionsToAdd[i]);
    };
  };

  $scope.removeOptions = function() {
    var optionsToRemove = $("#selected").find("option:selected");
    for (var i = 0; i < optionsToRemove.length; i++) {
      $("#available select").append(optionsToRemove[i]);
    };
  };
  $scope.sortStatOptions = function(fieldId) {
    var sorted = $(fieldId + " option").sort(function(a,b) {return $scope.stats.indexOf(a.innerHTML) - $scope.stats.indexOf(b.innerHTML);});
    $(fieldId + " option").remove();
    $(fieldId + " select").append(sorted);
  };
  $scope.setSlider = function() {
    $('#playtime').slider({
      formatter: function(value) {
        return "Min: " + value + " PA";
      }
    })
  };
  $('#playtime').slider()
    .on('slideStop', function() {
      $scope.minPa = $(this).slider('getValue');
      $scope.$apply();
      $scope.updateBatters();
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