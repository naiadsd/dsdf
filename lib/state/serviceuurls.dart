String baseURL =
    'https://us-central1-gelaterianaia-a3f12.cloudfunctions.net/app/';
String customersURL = "${baseURL}customer/getcustomers";
String createOrder = "${baseURL}order/createorder";
String itemsURL = "${baseURL}item/getItems";
String customersForDayAndRoute(int route, int day) =>
    "${baseURL}customer/getCustomersByRouteAndDay/$route/$day";
String customersForDayAndRouteWeek(int route, int day, int week) =>
    "${baseURL}customer/getCustomersByRouteAndDayAndWeek/$route/$day/$week";
