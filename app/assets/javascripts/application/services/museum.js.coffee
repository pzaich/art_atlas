ANM.factory "Museum", ($resource) ->
  $resource("/api/museums/:id", {id: "@id"}, {update: {method: "PUT"}})