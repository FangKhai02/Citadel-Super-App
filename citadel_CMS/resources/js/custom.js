document.addEventListener('DOMContentLoaded', function() {
    const forms = document.querySelectorAll('form'); // Select all forms
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            const submitButton = event.target.querySelector('button[type="submit"]');
            if (submitButton) {
                submitButton.disabled = true; // Disable the button
                submitButton.innerText = 'Processing...'; // Change the button text (optional)
            }
        });
    });
});

$(document).ready(function() {
    $('select.select2-ajax').each(function() {
        var $select = $(this);
        var availableOptions = []; // Store fetched options
    
        $select.select2({
            width: '100%',
            tags: $select.hasClass('taggable'),
            createTag: function(params) {
                var term = $.trim(params.term);
                if (term === '') {
                    return null;
                }
                return { id: term, text: term, newTag: true };
            },
            ajax: {
                url: $select.data('get-items-route'),
                data: function (params) {
                    return {
                        search: params.term,
                        type: $select.data('get-items-field'),
                        method: $select.data('method'),
                        id: $select.data('id'),
                        page: params.page || 1
                    };
                },
                processResults: function(data) {
                    // Store options globally, excluding "all"
                    availableOptions = data.results.filter(item => item.id !== 'all' && item.id !== '');
                    return { results: data.results };
                }
            }
        });
    
        $select.on('select2:select', function(e) {
            var data = e.params.data;
            if (data.id == '') {
                $(this).val([]).trigger('change'); // Clear all
            } else if (data.id == 'all') {
    
                // Get options including both ID and Text for 'all'
                var allOptionData = availableOptions.map(item => ({
                    id: item.id,
                    text: item.text
                }));
                
                // Add options if not already present
                allOptionData.forEach(option => {
                    if ($(this).find("option[value='" + option.id + "']").length === 0) {
                        $(this).append(new Option(option.text, option.id, false, false));
                    }
                });
    
                // Select all options
                $(this).val(allOptionData.map(option => option.id)).trigger('change'); // Set all
            } else {
                $(e.currentTarget).find("option[value='" + data.id + "']").attr('selected', 'selected');
            }
        });
    
        $select.on('select2:unselect', function(e) {
            var data = e.params.data;
            $(e.currentTarget).find("option[value='" + data.id + "']").attr('selected', false);
        });
    
        $select.on('select2:selecting', function(e) {
            if (!$select.hasClass('taggable')) return;
            var route = $select.data('route');
            var label = $select.data('label');
            var errorMessage = $select.data('error-message');
            var newTag = e.params.args.data.newTag;
    
            if (!newTag) return;
    
            $select.select2('close');
    
            $.post(route, {
                [label]: e.params.args.data.text,
                _tagging: true,
            }).done(function(data) {
                var newOption = new Option(e.params.args.data.text, data.data.id, false, true);
                $select.append(newOption).trigger('change');
            }).fail(function(error) {
                toastr.error(errorMessage);
            });
    
            return false;
        });
    });
    
    
});

