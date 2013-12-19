include('dispatch.ms')
   	
	proc(_make_hs,
	@loc = ploc()
    @size = 30 /* Whatever size you want */
	@rg = to_lower(player().'_hs')
    @sk_pos1 = array(
        floor((@loc[0] + (@size / 2))),
        256,
        floor((@loc[2] + (@size / 2))),
    )
    @sk_pos2 = array(
        floor((@loc[0] - (@size / 2))),
        0,
        floor((@loc[2] - (@size / 2))),
    )
        if(sk_region_exists('rg_'.player())) 
		{
            die(colorize('&cRegion already exists!'))
        }
        sk_region_create(pworld(), @rg, array(@sk_pos1, @sk_pos2))
        _check_hs(),
		),
		
	proc(_check_hs,
	@rg = to_lower(player().'_hs')
	if(array_size(sk_region_intersect(pworld(), @rg)) > 0)
		{
		 sk_region_remove(@rg) 
		 msg(color(red)'You cant make a homestead here please try farther away from other plots and regions')
		 }
		 else
		 {
		 _hs_final()
		 msg (color(green)'You have Successfully Created a Homestead')
		 }
	),

	proc(_hs_del,
	   @rname = to_lower(player().'_hs')
		
		sudo('/rg select '.@rname)
		sudo('//replace brick air')
		sudo('//replace fence air')
		sudo('//replace glowstone air')
		sk_region_remove(@rname)
		msg(color(green)'you have removed your homestead')
	 	),

	proc(_hs_final,
		
		sk_region_addowner( to_lower(player().'_hs'), pworld(), player())
		sk_region_setpriority( pworld(), to_lower(player().'_hs'),  20)
		skcb_load('hs')
		skcb_paste(ploc())
		sk_region_setparent(pworld(), to_lower(player().'_hs'), 'hs_parent') 
		sudo('/rg flag '.to_lower(player().'_hs').' teleport here')
		broadcast(color(3)'[server] '.player().' Has claimed a homestead')
		),
		
	proc(_hs_allreg,
	@allreg = sk_all_regions()
		array_remove_values(@allreg, '__global__') 
	@pworld = pworld()
	  
		msg (@allreg.'--')
	),


	proc(_check_overlap,
	@rg = to_lower(player().'_hs')
	@allregions = sk_all_regions()
	@remove__global__ = array_remove_values(@allregions, __global__)
		if (sk_region_overlaps(pworld(), @rg, @allregions))
	{
		msg('the regions overlap')
		msg('here are the regions ecluding global')
		msg(@allregions)
	}
	else
	{
		msg('the regions do not overlap')
	}
	),
	
	proc(_find,
	# cooldown time in second
        @cooldown = 300
 
        @timesince = time() - import('spreadme.timeout.' . player())
 
        if(@timesince > @cooldown * 1000) {  
                #sudo('/mv tp w_novum') # CHANGE THIS TO TELEPORT TO THE WORLD YOU WANT!
                sudo('/spreadplayers 10000 -35000 1 5000 false ' . player()) # INEVESTIGATE YOUR OWN VALUES
                export('spreadme.timeout.' . player(), time())
        } else {
                die(color('red') . 'Cooldown time left: ' . color('aqua') . (@cooldown - floor(@timesince / 1000)) . color('red') . ' seconds.' )
        }
	),
	
	proc(_myplots,
		assign(@pname,pinfo()[0])
    assign(@regions,sk_all_regions(pworld()))
    assign(@uregions, range(0)) # array() wasn't working
    foreach(@regions,@region,
       assign(@rowners,sk_region_info(@region, pworld()))
       if(array_contains_ic(@rowners[1],@pname), # needed case-insensitive comparison
          array_push(@uregions,concat(color(green),@region))
       )
    )
    assign(@urcount, array_size(@uregions))
    if(equals(@urcount,0),
        msg(color(green), 'You have no plots.'),
    # else
        if(equals(@urcount,1),
            msg(color(green), 'You have one plots: ', @uregions[0]),
        # else
            msg(color(green), 'You have ', @urcount, ' plots:')
            msg(array_implode(@uregions, concat(color(green),', ')))
        )
    )
    ),	
	
	proc(_addmember,
	 #_addmember(@args[0], @args[1], false),
	@owners = sk_region_owners(@args[0], 'main')
	@guest = @args[1]
	
	if (array_contains(array(@owners), player()))
	{
	msg ('the person is the owner of the region')
	}
	else
	{
	die(color(red)'you are not the owner of that region')
	}
	),
/*	proc(_list_sale,
	@allreg = sk_all_regions()
	@forslae = sk_region_flag(forsale)
*/











