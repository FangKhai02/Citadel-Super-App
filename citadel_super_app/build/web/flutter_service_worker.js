'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "4d5a78f13203cc6949c37c56848abca0",
"version.json": "c2f79833aa96348db747c4ab25db47e7",
"index.html": "e1603c775a484264568b803304d2d651",
"/": "e1603c775a484264568b803304d2d651",
"main.dart.js": "be9808a1a622fa3afaa0bbab8ebf6505",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "095fbc00e45d52a278ac51e561d3d584",
"icons/Icon-192.png": "f52a74c3e28d791cd22d4a48610ce576",
"icons/Icon-maskable-192.png": "f52a74c3e28d791cd22d4a48610ce576",
"icons/Icon-maskable-512.png": "71261c3e9872672830ca020f53732ec1",
"icons/Icon-512.png": "71261c3e9872672830ca020f53732ec1",
"manifest.json": "b846479f40741e27631b10e0b61e76e5",
"assets/AssetManifest.json": "706b44674931b1ca4651fe59a1333ca0",
"assets/NOTICES": "6251f675d385756d531ee662be92e450",
"assets/FontManifest.json": "0f9ca2d1fca91ab8bafaccca7c03f8f4",
"assets/AssetManifest.bin.json": "258abe60cdce1a073c68e897b747572c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "d9e55eb731477a0bc28dcd5746fb8de1",
"assets/fonts/MaterialIcons-Regular.otf": "99c7408b5faeb35b93a9458020f3d3bd",
"assets/assets/images/citadel_logo.png": "4f98eea236001d33a49ca5bf6125c6a8",
"assets/assets/images/backgrounds/dashboard_decoration_frame.png": "69988c0746027a875d477651472b8b52",
"assets/assets/images/backgrounds/gradient_decoration_frame.png": "316b7aff7a1a8a8585dc8e313c76568d",
"assets/assets/images/backgrounds/login_decoration_frame.png": "8de8cc8fc39ebfdf7a92b616e9d56437",
"assets/assets/images/backgrounds/identification_decoration_frame.png": "a3a275a2fd33e2be9ee15eebdd2ac2ad",
"assets/assets/images/backgrounds/sign_up_decoration_frame.png": "43ac62c6a789ab0240f3a64f74b24dc9",
"assets/assets/images/backgrounds/coming_soon.png": "68bce35f0ff2a05f45bc7723299e9785",
"assets/assets/images/backgrounds/sold.png": "daf83aab65fbf6e1c42318c9ed61dce4",
"assets/assets/images/temporary/fakeFundCGOTBackground.png": "0b41739237470bc2dc14e1c2f363a8f8",
"assets/assets/images/temporary/fakeFundICHFTBackground.png": "dd4fbe53c64f548a97a0080f39667681",
"assets/assets/images/temporary/fakeAgentPic.png": "ddc5ff570d7b56a64e06309a917f166c",
"assets/assets/images/temporary/fakeFundDetail.png": "6b34a35fbba9b83ea88d3356277d5d76",
"assets/assets/images/temporary/fakeFundICHTBackground.png": "6b4b15d7b1558776eb89a9ef06fce500",
"assets/assets/images/temporary/fakeUserPic.png": "38110d041fb8a5f818cbc315b1932f62",
"assets/assets/images/icons/Maintenance.png": "72cac711381c7274dff8dbd4cc03a806",
"assets/assets/images/icons/manual_submit_success.png": "deb0a514370de5bc1b6ca00ff8ff434c",
"assets/assets/images/icons/Document.png": "9c22d3cefc854a0142b90abe63631c5f",
"assets/assets/images/icons/selfies.png": "4ce711714e07a5cc82f813c91ec1c9a2",
"assets/assets/images/icons/Plus.png": "17584806f9551b2a14be2b4e0804f350",
"assets/assets/images/icons/OtherUnselect.png": "10cf6f25daabb59b4fbfd2910c1b716d",
"assets/assets/images/icons/goodbye.png": "6764c25ae69e71cbbf46a063b1dd94ed",
"assets/assets/images/icons/Tick.png": "65ce8bda6f8adcfeb8ceb37da1760484",
"assets/assets/images/icons/Icon.png": "b231e76bd518bc08149b3803a7c5e01e",
"assets/assets/images/icons/decrease.png": "a2d8bcf9c693f5a0762a0b36917e606b",
"assets/assets/images/icons/Rescan.png": "70529635fcedd504e0a657808aed25f4",
"assets/assets/images/icons/Retry.png": "b2d356d0cb3229c9fdaab8204d7bde47",
"assets/assets/images/icons/Download.png": "67b074b91abe5dfaa7da3304ab37be20",
"assets/assets/images/icons/Agent.png": "6a9b8dee424420cdba16252b9b700945",
"assets/assets/images/icons/gallery.png": "951641bdaaeaf253a5635d97e5c5c541",
"assets/assets/images/icons/consent_expired.png": "816baeb223e60f45b7db6368b51281e1",
"assets/assets/images/icons/CorporateUnselect.png": "0b4367ecef11a6e8acf6041281ac1e8e",
"assets/assets/images/icons/Dustbin.png": "8db874af119d2b4506c5c458dcea3f54",
"assets/assets/images/icons/Living_Trust_Icon.png": "1058e5bd82a5c3e24701dc48460f6205",
"assets/assets/images/icons/register_success.png": "e2ac7c36f4a4a1f0fba47009e63d55ba",
"assets/assets/images/icons/Terms.png": "ee79bcaa2e380531fe33c665ed492157",
"assets/assets/images/icons/Niu_Group.png": "1e13aa9aec3953af0f3dd00c0f82a41f",
"assets/assets/images/icons/Increase.png": "bb3544bbeb16a6f8a15a9642bb9fdb0c",
"assets/assets/images/icons/CitadelGroupCorporate.png": "ea214ecd34e2a3fc86f4890bb033bf72",
"assets/assets/images/icons/notification_promotion.png": "c6547b1cda9818f806306bbd9eef23ba",
"assets/assets/images/icons/bell_notification.png": "07f558533a079dd90344fa41f5daa61d",
"assets/assets/images/icons/Up.png": "fd5b66538f37f404092585e753f07367",
"assets/assets/images/icons/clear.png": "7077c8f3ed90e25ed34ff7fb6f9a543f",
"assets/assets/images/icons/total_sales.png": "232e8ef96a93e6c20c4ec5fc5afc0829",
"assets/assets/images/icons/cwp_agent.png": "b60a176dd60b72e766763d1d7e01f4cf",
"assets/assets/images/icons/download_blue.png": "183869886b730107b9692b6cdc62d711",
"assets/assets/images/icons/issued_id.png": "2fb813f3b99739010121a83a2ea72355",
"assets/assets/images/icons/fund_purchase_success.png": "97d9318b7ebd42a75a883f5e3471a04d",
"assets/assets/images/icons/logout.png": "1a25fc85baa03c967e4a4038d5700321",
"assets/assets/images/icons/Trust_fund.png": "99db5a1b6173887104d9f494e91322ba",
"assets/assets/images/icons/Alert.png": "c57c2af4e120a0e004cbf623e8e878b9",
"assets/assets/images/icons/Citadel_Trustee.png": "c5560883618845a0b324e88d0b348f86",
"assets/assets/images/icons/Home.png": "0a4cc8fe640c9545018ff3cd03dfb54f",
"assets/assets/images/icons/Shop.png": "e7a326fd7f8b979b3c5cfc0dc2215366",
"assets/assets/images/icons/online_banking.png": "ba495038bde64f0485665314f970a562",
"assets/assets/images/icons/CitadelUnselect.png": "7d0067e25e7c87972c1c6723fcace3d3",
"assets/assets/images/icons/face_scan.png": "d5858369053cf0d99361ab3812a7ce48",
"assets/assets/images/icons/citadelRejected.png": "fc71727e07542be89fc7ebd14a69e456",
"assets/assets/images/icons/consent_approved.png": "29968a9c45a371ac714650cb158e9473",
"assets/assets/images/icons/ProfitSharing.png": "a4688ee9ff93091bb038681944991518",
"assets/assets/images/icons/document%2520copy%25201.png": "96bbe3dda002723a8512fb2f8cd9a8f0",
"assets/assets/images/icons/total_product_sold.png": "aaea09f8bba19940cd598d14c5a18370",
"assets/assets/images/icons/NiuSelected.png": "287a9223620a3c0493092c95ce7a8b03",
"assets/assets/images/icons/Search.png": "4a9183fb45ca297f263b3d4121de1047",
"assets/assets/images/icons/Privacy.png": "76d4a727cb868c6059dfca86b4c5a0da",
"assets/assets/images/icons/CorparateSelected.png": "fcfcaf430eb38d9128632c2118e060b1",
"assets/assets/images/icons/payment_success.png": "6a68e9938dee965cfe25b1dc81af951b",
"assets/assets/images/icons/folder.png": "33617ef5f97757ef950986b1574c1a56",
"assets/assets/images/icons/secure_tag_consent.png": "6b7ad252827d6d157b2ccbff6e3d5bb1",
"assets/assets/images/icons/Minus.png": "10f33591a85e5dbb50e0d0ca3994fa80",
"assets/assets/images/icons/Password.png": "cee473c12dbecf334c19badf8cb6b9db",
"assets/assets/images/icons/company.png": "c0ad652ca73f911cf5bdc2fcffbaf17b",
"assets/assets/images/icons/Citadel_Agent.png": "c5447fbcf739d8845526c4f90ebffd47",
"assets/assets/images/icons/multi_user.png": "73f151bab4e577fef18ecc56ff8dd730",
"assets/assets/images/icons/Upload.png": "502e47c048233a591a47af2836d67b89",
"assets/assets/images/icons/payment_fail.png": "bd87634a9736d381d45ffca64ccb7b88",
"assets/assets/images/icons/graph-arrow-increase--ascend-growth-up-arrow-stats-graph-right-grow.png": "773b23cd3e6647d74fa67dd1cd33ec2b",
"assets/assets/images/icons/Cross.png": "836268d0bae0a568578528bd4cb515b0",
"assets/assets/images/icons/Calendar.png": "7767c7a22680e308e7aa452915542091",
"assets/assets/images/icons/View.png": "66016111c24b4095aeaba4ab72259fb6",
"assets/assets/images/icons/See%2520more.png": "f1537c5649cefe6955e0a0351ba965c7",
"assets/assets/images/icons/NiuUnselect.png": "6d0c787753cc41ff5c32a28c411b16b3",
"assets/assets/images/icons/Dropdown.png": "e01320794e98f0205dfec3d21e369b4d",
"assets/assets/images/icons/Document_submit.png": "c7b78372e2f63b49fd7bec8f14eb3851",
"assets/assets/images/icons/share.png": "7ce18a1f5e1842a81d3612185ff42521",
"assets/assets/images/icons/Profile.png": "9667054ac686bf5367406c4169802951",
"assets/assets/images/icons/CitadelGroupNiu.png": "06deb6573d06afddf202695fdbb658f8",
"assets/assets/images/icons/Corporate_Trustee_Application.png": "20a2fa2df9b7082e87660b0e852ec079",
"assets/assets/images/icons/CitadelSelected.png": "1bc24eb2adf55572cb0b3612f117e8eb",
"assets/assets/images/icons/maintenance_schedule.png": "5168b5eec6694c4d88e1fa247d6e2551",
"assets/assets/images/icons/change_password.png": "77ab415ff3bef01e39c9b76842e22306",
"assets/assets/images/icons/phone.png": "50ece3db579040381a1fabf15dc6a85b",
"assets/assets/images/icons/delete.png": "5deca35db189f3ee32eadc4137541cdb",
"assets/assets/images/icons/account_statement.png": "66419592ea7023c15cdcc94cad6a43c9",
"assets/assets/images/icons/change_security_pin.png": "53935b57bc101a546c14c69c95698add",
"assets/assets/images/icons/loan.png": "477d17854e9e2e8e1fb8718098780484",
"assets/assets/images/icons/dividend.png": "32f1d729e12193a0bbdad477f9f2308a",
"assets/assets/images/icons/passwordSuccess.png": "6732984d2f11e8692752713426bbf3c9",
"assets/assets/images/icons/CitadelTrusteeCompany.png": "de6ecaccd4bac44c7ec8ac2fbdf69f0a",
"assets/assets/images/icons/Group%25207898.png": "d08e68816b6514613a26b10aa0a5bab8",
"assets/assets/images/icons/OfficialReceipt.png": "284726a19c642994c0a27d5a6197b58e",
"assets/assets/images/icons/Edit.png": "3e29214fc59700bd8a2fc8bb7b0ac1f5",
"assets/assets/images/icons/Star.png": "a5e36e27880d60dd6cda8ca08fc09bd5",
"assets/assets/images/icons/More.png": "4c7bb008cd7e8b9d0628e4469a2af6a5",
"assets/assets/images/icons/OtherSelected.png": "d4f18c767570f2ece01d3309165eb9e8",
"assets/assets/images/icons/pending_consent.png": "2cee7e2540cf6042463547ac4a880ef8",
"assets/assets/images/icons/Niu_Application.png": "43c336e36fcebc23c3878afea5a85d40",
"assets/assets/images/icons/camera.png": "e4ddab5d91a3ab77e76d3e0609e78d65",
"assets/assets/images/icons/notification_message.png": "6b99dbb7d051317d5311e4c6984a1b57",
"assets/assets/images/icons/Notification.png": "2005a2d183365de340ac50bd66892a5f",
"assets/assets/images/icons/Message.png": "5e93c1ecadf9dc8a962ca34871427641",
"assets/assets/images/icons/manual_transfer.png": "346cf1d416a9d436f9659ec84a657ffd",
"assets/assets/images/icons/Back.png": "2db3161d3cb5a52d3292eeb0be971184",
"assets/assets/images/icons/Right.png": "64694b26b069f12b4b9c5e2d2b005629",
"assets/assets/images/icons/Client.png": "7a83af21a8cd868f0cf3296e335a9709",
"assets/assets/images/icons/personal.png": "7cba5a66a0c491bdc7f0068a8e302e2c",
"assets/assets/images/icons/Copy.png": "4aa2c4c9b8a2f53ad255f758e52359d5",
"assets/assets/images/icons/calendar_blue.png": "1172fe91229b6422086e7508320916ed",
"assets/assets/json/postcode.json": "a955384a11bfd549738a831a5d662733",
"assets/assets/json/bank.json": "84e342e9963a808c70ed43d9fcd40cfb",
"assets/assets/json/countries.json": "c0eded5942333c1f67d974ace2907cc5",
"assets/assets/fonts/ITCAvantGardeStd-Medium.otf": "8c3c83c18a0d678275215d244578a6cd",
"assets/assets/fonts/ITCAvantGardeStd-Book.otf": "b17a6fcf71d7f639be83e59cb08896a8",
"assets/assets/fonts/ITCAvantGardeStd-Bold.otf": "e7ff68f5fb97d6c4db056a275d6d2522",
"assets/assets/fonts/ITCAvantGardeStd-ExtraLight.otf": "217e7d7f3d9c94234f529d93fab55ec9",
"assets/assets/fonts/ITCAvantGardeStd-Demi.otf": "5d6673c4275c725f69700efd0dcdbf20",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
