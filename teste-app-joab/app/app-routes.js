(function () {
    'use strict';

    angular.module('nomeDoSeuProjetoApp').config(['$routeProvider', '$locationProvider', ApplicationConfig]);

    function ApplicationConfig($routeProvider, $locationProvider) {

        var sessionRoutes = JSON.parse(window.localStorage['PLING-MODULES']);

        if (!sessionRoutes) {
            throw new Error('Rotas não encontradas!');
        }

        sessionRoutes.forEach(function (module, index) {
            var crud = {};

            if (!module.route) return false;

            // APARECE NO MENU?
            if (module.config.isMenu && module.config.hasContent) {

                module.templateUrl  = 'app/components' + module.route + '/' + module.route.split('/')[1] + '.html';
                module.controller   = module.route.split('/')[1].charAt(0).toUpperCase() + module.route.split('/')[1].slice(1) + 'Controller';

            } else if (module.config.isMenu && !module.config.hasContent) {

                crud.templateUrl = 'app/components' + module.route + '/' + module.route.split('/')[1] + '-crud.html';
                crud.controller  = module.route.split('/')[1].charAt(0).toUpperCase() + module.route.split('/')[1].slice(1) + 'CrudController';

                // DOIS NIVEIS DE ROTA PARA TODOS CRUDS
                crud.route =  module.route + '/:id/:name?/:id?';

            // POSSUI CONTEUDO, MAS NÃO É ITEM DE MENU, SUBMENU OU TAB --> (home)
            } else if (module.config.hasContent && !module.config.isMenu && !module.config.isSubMenu && !module.config.isTab && !module.config.isMultiple) {

                module.templateUrl  = 'app/components' + module.route + '/' + module.route.split('/')[1] + '.html';
                module.controller   = module.route.split('/')[1].charAt(0).toUpperCase() + module.route.split('/')[1].slice(1) + 'Controller';

            // É UM SUBMENU?
            } else if (module.config.isSubMenu && module.config.hasContent && module.parent) {

                module.templateUrl  = 'app/components' + module.route + '/' + module.route.split('/')[2] + '.html';
                module.controller   =  module.route.split('/')[1].charAt(0).toUpperCase() + module.route.split('/')[1].slice(1) + module.route.split('/')[2].charAt(0).toUpperCase() + module.route.split('/')[2].slice(1) + 'Controller';

            }

            if (module.config.isTab && module.parent) {

                // CRUD É O MODULO DE VIEW/EDIT/DELETE DO MODULO PARENT
                crud.templateUrl = 'app/components' + module.parent +  module.parent + '-crud.html';
                crud.controller  = module.parent.split('/')[1].charAt(0).toUpperCase() + module.parent.split('/')[1].slice(1) + 'CrudController';
                crud.route       = module.parent + '/:id?/:name?/:id?';

            } else if (module.templateUrl && module.route && module.config.isMultiple) {

                // CRUD É O MODULO DE VIEW/EDIT/DELETE DO MODULO PARENT
                crud.templateUrl = module.templateUrl.split('.html')[0] + '-crud.html';
                crud.controller  = module.route.split('/')[1].charAt(0).toUpperCase() + module.route.split('/')[1].slice(1) + 'CrudController';

                // DOIS NIVEIS DE ROTA PARA TODOS CRUDS
                crud.route =  module.route + '/:id?/:name?/:id?';
            }

            // REGISTRO DAS ROTAS
            if (module.templateUrl && module.controller && module.config.hasContent) {
                $routeProvider
                    .when(module.route, {
                        'templateUrl'    : module.templateUrl,
                        'controller'     : module.controller,
                        'controllerAs'   : 'ctrl',
                        'reloadOnSearch' : false
                    });
            }

            if (crud.route && crud.controller) {

                // MÓDULO FILHO
                $routeProvider
                    .when(crud.route, {
                        'templateUrl'    : crud.templateUrl,
                        'controller'     : crud.controller,
                        'controllerAs'   : 'ctrl',
                        'reloadOnSearch' : false
                    });
            }

            if (index + 1 === sessionRoutes.length) {
                $routeProvider.otherwise({
                    'redirectTo': '/home'
                });

                $locationProvider.html5Mode(true);
            }
        });
    }
}());