module ApplicationHelper
  def authenticate
    deny_access unless signed_in?
  end


  def logo
     #image_tag("logo-kette-transparent-text.png", :alt => "Logo Kette", :class => "left") #, :width => "200", :height=> "150")
     image_tag("trikot-trans-small.png", :alt => "Logo Kette", :class => "left") #, :width => "200", :height=> "150")
  end

  def small_logo
     image_tag("trikot-trans-small-small.png", :alt => "Small logo", :class => "left")
  end

  def tour_type_logo(tour_type)
      if tour_type == "MTB"
        image_tag("mtb-icon.png", :alt => "Icon MTB", :class=> 'left')
      end
      if !tour_type == "Veranstaltung"
      else 
        image_tag("rr-icon.jpg", :alt => "Icon Rennrad", :class=> 'left')
      end
  end

  def heading_builder(page_id)
    content = ""    
    content << t('views.tour.month.heading')  << content_tag('small'," " + t('views.tour.month.heading_sub')) if (page_id.start_with? "tour_")    
    content << t('views.track.index.heading') << content_tag('small'," " + t('views.track.index.heading_sub')) if (page_id.start_with? "track_")    
    content << t('views.user.index.heading')  << content_tag('small'," " + t('views.user.index.heading_sub')) if (page_id.start_with? "user_")
    content << t('views.post.index.heading')  << content_tag('small'," " + t('views.post.index.heading_sub'))      if (page_id.start_with? "post_")
    content << t('views.calendar.index.heading')  << content_tag('small'," " + t('views.calendar.index.heading_sub')) if (page_id.start_with? "calender_")
    content << "Anmelden<small> um mal was Sinnvolles zu tun</small>" if (page_id.start_with? "session_")
    content << t('views.statistic.index.heading')  << content_tag('small'," " + t('views.statistic.index.heading_sub')) if (page_id.start_with? "statistic_")
    content << "Changelog<small> was gibt es Neues auf der Seite</small>" if (page_id.start_with? "sessions_changelog")
    content << "Impressum" if (page_id.start_with? "sessions_imprint")
    content_tag("h1", content,{}, false)
  end

  def menu_builder(page_id)
    content = ""
    if page_id.start_with? "tour_"
      content << content_tag('li', content_tag('a', t('views.tour.menu'), :href => month_path), :class=>'active')
    else
      content << content_tag('li', content_tag('a',t('views.tour.menu'), :href => month_path))
    end
    
    if signed_in?
      if page_id.start_with? "track_"
        content << content_tag('li', content_tag('a',t('views.track.menu'), :href => tracks_path), :class=>'active')
      else
        content << content_tag('li', content_tag('a',t('views.track.menu'), :href => tracks_path))
      end
    end

    if signed_in?
      if page_id.start_with? "user_"     
        content << content_tag('li', content_tag('a',t('views.user.menu'), :href => users_path), :class=>'active')
      else
        content << content_tag('li', content_tag('a',t('views.user.menu'), :href => users_path)) 
      end
    end
    
    if signed_in?
      if page_id.start_with? "statistic_"     
        content << content_tag('li', content_tag('a',t('views.statistic.menu'), :href => user_statistics_path), :class=>'active')
      else
        content << content_tag('li', content_tag('a',t('views.statistic.menu'), :href => user_statistics_path)) 
      end
    end

    if signed_in?
      if page_id.start_with? "post_"     
        content << content_tag('li', content_tag('a',t('views.post.menu'), :href => posts_path), :class=>'active')
      else
        content << content_tag('li', content_tag('a',t('views.post.menu'), :href => posts_path)) 
      end
    end

    if signed_in?
      if page_id.start_with? "calender_"     
        content << content_tag('li', content_tag('a',t('views.calendar.menu'), :href => calenders_path), :class=>'active')
      else
        content << content_tag('li', content_tag('a',t('views.calendar.menu'), :href => calenders_path)) 
      end
    end

    if signed_in?
      if page_id.start_with? "user_edit"     
        content << content_tag('li', content_tag('a',t('views.user.profil'), :href => edit_user_path(current_user)), :class=>'active')
      else
        content << content_tag('li', content_tag('a',t('views.user.profil'), :href => edit_user_path(current_user))) 
      end
    end


    if signed_in? && current_user.groups.size > 1
      content << content_tag('li', '',:class=>'divider-vertical')
      content << group_dropdown
    end
    
    #content << content_tag('li', '',:class=>'divider-vertical')

    #if page_id.start_with? "sessions_changelog"     
    #  content << content_tag('li', content_tag('a',"Changelog", :href => changelog_path), :class=>'active')
    #else
    #  content << content_tag('li', content_tag('a',"Changelog", :href => changelog_path)) 
    #end
    #content << content_tag('li', '',:class=>'divider-vertical')


    content_tag(:ul, content, {:class=>'nav'}, false)
  end

  def sub_menu_builder(page_id)
    content = ""
    if page_id.starts_with? "tour_"
      content << '<a class="btn" href="'+all_path+'"><i class="icon-list"></i> '+t('views.tour.sub.all')+'</a>'
      content << '<a class="btn" href="'+month_path+'"><i class="icon-th-large"></i> '+t('views.tour.sub.month')+'</a>'
 
      if signed_in?
        content << '<a class="btn" href="'+own_tours_path+'"><i class="icon-heart"></i> '+t('views.tour.sub.own')+'</a>'
        content << '<a class="btn" href="'+own_tours_path+'"><i class="icon-book"></i> '+t('views.tour.sub.diary')+'</a>'
        content << "<a class='btn' data-toggle='modal' href='#modal_new_tour' data-backdrop='static'><i class='icon-plus'></i> "+t('views.tour.sub.new')+'</a>'
        content << '<a class="btn" href="'+notclosed_tours_path+'"><i class="icon-road"></i> '+t('views.tour.sub.notclosed')+'</a>'
      end
    end

    if page_id.starts_with? "track_"
      content << '<a class="btn" href="'+tracks_path+'"><i class="icon-list"></i> Alle</a>'
      content << '<a class="btn" href="'+mtb_tracks_path+'"><i class="icon-th-large"></i> Nur MTB</a>'
      content << '<a class="btn" href="'+rr_tracks_path+'"><i class="icon-th-large"></i> Nur Rennrad</a>'
    end

    if page_id.start_with? "user_"
      content << '<a class="btn" href="'+user_list_path+'"><i class="icon-list"></i> Alle</a>'
      content << "<a class='btn' href='/users/new'><i class='icon-plus'></i> Neuer User</a>"
    end
    
    if page_id.start_with? "post_"  
      content << '<a class="btn" href="'+posts_path+'"><i class="icon-list"></i> Alle</a>'
      content << '<a class="btn" href="'+new_post_path+'"><i class="icon-plus"></i> Neuer Eintrag</a>'
    end

    if page_id.start_with? "statistic_" 
      content << '<a class="btn" href="' + user_statistics_path + '"><i class="icon-user"></i> Mitfahrer</a>'
      content << '<a class="btn" href="' + tour_statistics_path + '"><i class="icon-road"></i> Touren</a>'
      content << '<a class="btn" href="' + diary_statistics_path + '"><i class="icon-calendar"></i> Gesamt</a>'
    end
    if page_id.start_with? "calender_" 
      content << '<a class="btn" href="' + calenders_path + '"><i class="icon-list"></i> Alle</a>'
      content << '<a class="btn" href="' + calendar_month_path + '"><i class="icon-th-large"></i> Monat</a>'
      content << "<a class='btn' data-toggle='modal' href='#modal_new_calender_' data-backdrop='static'><i class='icon-plus'></i> Neuer Eintrag</a>" if signed_in?
    end
    content_tag(:div, content,{ :class=>'btn-group', 'data-toggle'=>"buttons-radio"}, false)
  end

  def group_dropdown      
    return if current_user.groups.size == 1

    content =  "<ul class='nav'>"
    content << "<li class='dropdown'>"
    current_user.groups.each do |group|
      content << "<a href='#' data-toggle='dropdown' class='dropdown-toggle'>" + group.name + "<b class='caret'></b></a>" if current_user.preferred_group == group.id
    end

    content << "<ul class='dropdown-menu'>"
    current_user.groups.each do |group|
      if (current_user.preferred_group == group.id)
        content << "<li class='active'>" + content_tag('a', group.name, :href => group_url(:user_id => current_user.id, :group_id => group.id)) + "</li>"
      else
        content << "<li>" + content_tag('a', group.name, :href => change_group_url(:user_id => current_user.id, :group_id => group.id)) + "</li>"
      end
    end
    content << "</ul></li></ul>"
    content
  end
end