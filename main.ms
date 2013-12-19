

/*bind(sign_changed, null null, @event,
	assign(@signText, @event['text']
 if(@signText['0'] == '[plot]')


bind(block_break, null, null, @event,
@text = get_sign_text(@event['location'])
    if(@event['block']['type'] == 323) 
	{
        

    }
)

bind(sign_changed, null, null, @event,
    assign(@signText, @event['text'])
    {
        if(!has_permission(@event['player'], 'spleef.admin')) {
            set_block_at(@event['location'], '0')
            pgive_item(@event['player'], '323')
            die()
        }
        set_timeout(1000,
            closure(@signText, @event,
                set_sign_text(@event['location'], array(colorize('&6[&3Spleef&6]'), colorize(@signText['1']), colorize(@signText['2']), colorize(@signText['3'])))
                die(colorize('&3Spleef&6:&e Created Spleef sign. Do you want a cookie?'))
            )
        )
    }
)

bind(sign_changed, null, null, @event,
    assign(@signText, @event['text'])
    if(@signText['0'] == '[Spleef]' || @signText['0'] == '&6[&3Spleef&6]') {
        if(!has_permission(@event['player'], 'spleef.admin')) {
            set_block_at(@event['location'], '0')
            pgive_item(@event['player'], '323')
            die()
        }
        set_timeout(1000,
            closure(@signText, @event,
                set_sign_text(@event['location'], array(colorize('&6[&3Spleef&6]'), colorize(@signText['1']), colorize(@signText['2']), colorize(@signText['3'])))
                die(colorize('&3Spleef&6:&e Created Spleef sign. Do you want a cookie?'))
            )
        )
    }
)

*/