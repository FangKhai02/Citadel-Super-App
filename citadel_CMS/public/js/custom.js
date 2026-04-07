/******/ (() => { // webpackBootstrap
/*!********************************!*\
  !*** ./resources/js/custom.js ***!
  \********************************/
function _typeof(o) { "@babel/helpers - typeof"; return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (o) { return typeof o; } : function (o) { return o && "function" == typeof Symbol && o.constructor === Symbol && o !== Symbol.prototype ? "symbol" : typeof o; }, _typeof(o); }
function _defineProperty(e, r, t) { return (r = _toPropertyKey(r)) in e ? Object.defineProperty(e, r, { value: t, enumerable: !0, configurable: !0, writable: !0 }) : e[r] = t, e; }
function _toPropertyKey(t) { var i = _toPrimitive(t, "string"); return "symbol" == _typeof(i) ? i : i + ""; }
function _toPrimitive(t, r) { if ("object" != _typeof(t) || !t) return t; var e = t[Symbol.toPrimitive]; if (void 0 !== e) { var i = e.call(t, r || "default"); if ("object" != _typeof(i)) return i; throw new TypeError("@@toPrimitive must return a primitive value."); } return ("string" === r ? String : Number)(t); }
document.addEventListener('DOMContentLoaded', function () {
  var forms = document.querySelectorAll('form'); // Select all forms
  forms.forEach(function (form) {
    form.addEventListener('submit', function (event) {
      var submitButton = event.target.querySelector('button[type="submit"]');
      if (submitButton) {
        submitButton.disabled = true; // Disable the button
        submitButton.innerText = 'Processing...'; // Change the button text (optional)
      }
    });
  });
});
$(document).ready(function () {
  $('select.select2-ajax').each(function () {
    var $select = $(this);
    var availableOptions = []; // Store fetched options

    $select.select2({
      width: '100%',
      tags: $select.hasClass('taggable'),
      createTag: function createTag(params) {
        var term = $.trim(params.term);
        if (term === '') {
          return null;
        }
        return {
          id: term,
          text: term,
          newTag: true
        };
      },
      ajax: {
        url: $select.data('get-items-route'),
        data: function data(params) {
          return {
            search: params.term,
            type: $select.data('get-items-field'),
            method: $select.data('method'),
            id: $select.data('id'),
            page: params.page || 1
          };
        },
        processResults: function processResults(data) {
          // Store options globally, excluding "all"
          availableOptions = data.results.filter(function (item) {
            return item.id !== 'all' && item.id !== '';
          });
          return {
            results: data.results
          };
        }
      }
    });
    $select.on('select2:select', function (e) {
      var _this = this;
      var data = e.params.data;
      if (data.id == '') {
        $(this).val([]).trigger('change'); // Clear all
      } else if (data.id == 'all') {
        // Get options including both ID and Text for 'all'
        var allOptionData = availableOptions.map(function (item) {
          return {
            id: item.id,
            text: item.text
          };
        });

        // Add options if not already present
        allOptionData.forEach(function (option) {
          if ($(_this).find("option[value='" + option.id + "']").length === 0) {
            $(_this).append(new Option(option.text, option.id, false, false));
          }
        });

        // Select all options
        $(this).val(allOptionData.map(function (option) {
          return option.id;
        })).trigger('change'); // Set all
      } else {
        $(e.currentTarget).find("option[value='" + data.id + "']").attr('selected', 'selected');
      }
    });
    $select.on('select2:unselect', function (e) {
      var data = e.params.data;
      $(e.currentTarget).find("option[value='" + data.id + "']").attr('selected', false);
    });
    $select.on('select2:selecting', function (e) {
      if (!$select.hasClass('taggable')) return;
      var route = $select.data('route');
      var label = $select.data('label');
      var errorMessage = $select.data('error-message');
      var newTag = e.params.args.data.newTag;
      if (!newTag) return;
      $select.select2('close');
      $.post(route, _defineProperty(_defineProperty({}, label, e.params.args.data.text), "_tagging", true)).done(function (data) {
        var newOption = new Option(e.params.args.data.text, data.data.id, false, true);
        $select.append(newOption).trigger('change');
      }).fail(function (error) {
        toastr.error(errorMessage);
      });
      return false;
    });
  });
});
/******/ })()
;