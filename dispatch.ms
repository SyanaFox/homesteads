proc(_hs_dispatch, @input,
  
  
  #parse the incoming commands depending on the first command
  #if called with empty command
  
  @match = parse_args(@input)
  if(array_size(@match)) 
  {
        @first = array_remove(@match, 0)
        @args = @match
    } 
    else 
    {
    msg ('-/hs find - finds a suitable place for a plot')
    msg ('-/hs make - makes the homestead')
    msg ('-/hs release - releases your homestead')
    #msg ('-/hs cleanup - cleans the expired plots > 60days')
    return()
	}
    
    switch (@first,
    'update',
	 (
	 run('/rg save')
	 run('/rg reload')
        die(),
	),
	
	'make',
	
	if (sk_region_exists(player().'_hs'))
	{ 
	die(color(red)'you already have a homestead')
	}
	else
	{
	_make_hs()
	/*_check_hs()*/
     },
	
	'test',
	
	if (sk_region_exists(player().'_hs'))
	{ 
	_check_hs()
	}
	else
	{
	msg('you dont have a homestead created')
	},
	
	'release_hs',
	
	if (sk_region_exists(player().'_hs'))
	{
	_hs_del(),
	}
	else
	{
	die(color(red)'you dont have a homestead to release')
	},
	
	'find',
	
	/*if (sk_region_exists(player().'_hs'))
	{ 
	die(color(red)'you already have a homestead so you dont need to find one')
	}
	else
	{
	
	},
	*/
	_find(),
	
	'sales',
	if (has_permission('chplots.sales'))
	{
	_list_sale(),
	}
	else
	{
	die(color(red)'You dont have permissions for this function')
	},
	
	'list',
    
	_myplots(),
	
	'addmember',
	   _addmember(@args[0], @args[1], false),
	   
/*	if(array_size(@args))
	{
	
	_addmember(),
	*/
	) /*switch end */
	) /*proc end */
	