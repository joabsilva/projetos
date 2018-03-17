(function () {
    'use strict';

    // injecting dependencies
    MainController.$inject = [
        '$scope', '$rootScope', '$timeout',
        '$location', '$window', 'coreApiService',
        '$mdToast', 'httpHelperService'
    ];

    // registering on angular
    angular.module('nomeDoSeuProjetoApp').controller('MainController', MainController);

    // Main Controller
    function MainController($scope, $rootScope, $timeout, $location, $window, core, $mdToast, httpHelperService) {

        var last = {
            'bottom' : true,
            'top'    : false,
            'left'   : true,
            'right'  : false
        };

        // Configurações
        $rootScope.config = {

            'chat': {
                'isLoadOnStart' : false
            }

        };

        // store the url to redirect later in case the user comes from other domain
        $rootScope.isAppLoaded  = false;
        $rootScope.loadingLayer = false;
        $rootScope.isAppLoading = true;

        /* TOAST NOTIFIER */
        function sanitizePosition() {
            var current = $scope.toastPosition;

            if (current.bottom && last.top) { current.top = false; }
            if (current.top && last.bottom) { current.bottom = false; }
            if (current.right && last.left) { current.left = false; }
            if (current.left && last.right) { current.right = false; }

            last = angular.extend({}, current);
        }

        $scope.toastPosition = angular.extend({}, last);
        $scope.getToastPosition = function () {
            sanitizePosition();

            return Object.keys($scope.toastPosition)
                .filter(function (pos) { return $scope.toastPosition[pos]; })
                .join(' ');
        };

        $rootScope.toast = function (text, delay) {
            $mdToast.show(
                $mdToast.simple()
                    .textContent(text)
                    .position($scope.getToastPosition())
                    .hideDelay(delay || 2000)
            );
        };

        // Route change
        $rootScope.$on('$routeChangeStart', function () {
            $rootScope.isAppLoading = true;
        });

        $rootScope.$on('$routeChangeSuccess', function () {
            $rootScope.isAppLoading = false;
        });

        // Registring Logout
        $rootScope.$on('PLING-SERVICE-BAR-LOGOUT', function () {
            core.redirectToLoginWithCallback();
        });

        // Service bar loader
        $rootScope.$on('PLING-SERVICE-BAR-ISLOADING', function (event, isLoading) {
            $rootScope.isAppLoaded = !isLoading;
        });

        // Application loader
        $rootScope.$on('PLING-APP-ISLOADING', function () {
            $rootScope.isAppLoading = !$rootScope.isAppLoading;
        });

        $rootScope.$on('PLING-REDIRECT', function (event, url) {
            $rootScope.isAppLoaded = false;
            $window.location.href = url;
        });

        $rootScope.$on('CANCEL-REQUESTS', function () {
            httpHelperService.cancelRequest();
        });

    }
}());
