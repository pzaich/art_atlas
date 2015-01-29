ANM.factory "Painting", ($resource) ->
  $resource("/api/paintings/:id", {id: "@id"}, {update: {method: "PUT"}})