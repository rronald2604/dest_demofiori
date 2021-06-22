using {dest_demofiori.db as db} from '../db/data-model';

using {CV_SALES} from '../db/data-model';


using { API_SALES_ORDER_SRV } from './external/API_SALES_ORDER_SRV.csn';








service CatalogService @(path : '/catalog')
@(requires: 'authenticated-user')
{
    entity Sales
      @(restrict: [{ grant: ['READ'],
                     to: 'Viewer'
                   },
                   { grant: ['WRITE'],
                     to: 'Admin' 
                   }
                  ])
      as select * from db.Sales
      actions {
        @(restrict: [{ to: 'Viewer' }])
        function largestOrder() returns String;
        @(restrict: [{ to: 'Admin' }])
        action boost();
      }
    ;

    @readonly
    entity VSales
      @(restrict: [{ to: 'Viewer' }])
      as select * from CV_SALES
    ;

    function topSales
      @(restrict: [{ to: 'Viewer' }])
      (amount: Integer)
      returns many Sales;


    @readonly
    entity SalesOrders
      @(restrict: [{ to: 'Viewer' }])
      as projection on API_SALES_ORDER_SRV.A_SalesOrder {
          SalesOrder,
          SalesOrganization,
          DistributionChannel,
          SoldToParty,
          IncotermsLocation1,
          TotalNetAmount,
          TransactionCurrency
        };









    type userScopes { identified: Boolean; authenticated: Boolean; Viewer: Boolean; Admin: Boolean; };
    type user { user: String; locale: String; scopes: userScopes; };
    function userInfo() returns user;
};
