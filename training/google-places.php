<?php
// create a new cURL resource
$curl = curl_init();
require_once("/usr/local/etc/private/google-api-local-rank-tracker.inc");

// Test for places in San Fran.
//$url = https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' . $input . '&types=establishment&location=13.052415, 80.250824&radius=500&sensor=true&key=KEY';
//$url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' . $input . '&types=establishment&location=13.052415, 80.250824&radius=500&sensor=true&key=KEY';
// Works: $url = 'https://maps.googleapis.com/maps/api/place/search/json?location=' . urlencode("37.787930,-122.4074990") . '&radius=1000&key=KEY';
// Test for keyword coffee in San Fran.
// Works: $url = 'https://maps.googleapis.com/maps/api/place/search/json?location=' . urlencode("37.787930,-122.4074990") . '&radius=1000&key=' . GOOGLE_API;

$coordinates = "38.8673,-104.7607";
$distance = 1500*5; // Approx 5 mile radius.
// Does not give next_page_token
$url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=auto+repair+colorado+springs&location=' . urlencode($coordinates) . '&radius=' . urlencode($distance) . '&key=' . GOOGLE_API;
$next_page_token = '';

//$next_page_token = 'CoQC-QAAAMNYMvxWjTSEbcya_84pLEztTxBIzTVEdARWtCw-8gZhCEk14dALpVLZiRd1lQsIL9scPZ8KYKPQaCVLKXj5qrKATF_a2D2wtBUuIOrVJjxQT8XmW2RG-_klUi6jpHoWRND8g53xUdNYGHRiZpcTQFKcfqgH5BZM43-vH1mH72dqA37tnbgxu1z9_CjfhEEBbl62WFbawfI5g1lPgOpUevOLsUBG_WYjBgquybphqUKWc4NuRclFQOOO7sPell9LSckJIEOi8om2-SuumKKWqib83i0fA_SRun4RP1i30O6LKqbPxltg9_X1jxy9fr7-jLV6w5omfxhorK3Urf8s670SEDZeySvMtlY4qwozIfVpVEcaFDEcTYZjqqU11d9fVuPutvS0MQdO';

if (isset($next_page_token) && '' !== trim($next_page_token)) {
    $url = $url . '&pagetoken=' . $next_page_token;
}

// DEBUG
echo "URL: " . $url . PHP_EOL;

//$url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&rankby=distance&types=food&key=' . GOOGLE_API;

//$url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/xml?location=42.9825,-81.254&radius=50000&name=Medical%22Clinic&sensor=false&key=' . GOOGLE_API;

// Colorado Springs, Coordinates:
// 38.8673° N, 104.7607° W

curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
$resp = curl_exec($curl);
curl_close($curl);
var_dump($resp);
