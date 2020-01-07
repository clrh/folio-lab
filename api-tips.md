# API tips

## Users

### indexField is great

```
{{base_url}}/perms/users/{{ other_user_id  }} 
=> No user with id: 78c51a90-e64f-49ce-8d28-e246a49c7f63
```

```
{{base_url}}/perms/users/{{ other_user_id  }}?indexField=userId 
=> Helps
```

`indexField` is used in many API endpoints and basically means, “The `id` field in the path doesn’t point to this type’s primary key; it is a foreign key referencing the given field.” (via Zak Burke)

## Permissions

### Simply get the perms for a user OR Get the userId

```
# Get the userId
GET {{base_url}}/bl-users/by-username/<username> 
```

### Find the id to pass in this API context
```
# Find the id for perm with this id
GET {{ base_url  }}/perms/users?length=4000
# and grep the userId to get the good id
```
```
# or use indexField
{{ base_url  }}/perms/users/<userId>/permissions?indexField=userId
# test the id 
GET {{ base_url  }}/perms/users/fda3b1cd-4a00-4acb-9245-99c987f8a3cb/permissions

```
### Post the permission to add

```
POST {{ base_url  }}/perms/users/fda3b1cd-4a00-4acb-9245-99c987f8a3cb/permissions
{
	"permissionName": "mapping-rules.get"
}
```

