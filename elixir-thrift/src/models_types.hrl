-ifndef(_models_types_included).
-define(_models_types_included, yeah).

%% struct 'Message'

-record('Message', {'url' :: string() | binary(),
                    'payload' :: string() | binary()}).
-type 'Message'() :: #'Message'{}.

-endif.
