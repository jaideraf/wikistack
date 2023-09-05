<?php
/** Georgian (ქართული)
 *
 * To improve a translation please visit https://translatewiki.net
 *
 * @file
 * @ingroup Languages
 */

$namespaceNames = [
	NS_MEDIA            => 'მედია',
	NS_SPECIAL          => 'სპეციალური',
	NS_TALK             => 'განხილვა',
	NS_USER             => 'მომხმარებელი',
	NS_USER_TALK        => 'მომხმარებლის_განხილვა',
	NS_PROJECT_TALK     => '$1_განხილვა',
	NS_FILE             => 'ფაილი',
	NS_FILE_TALK        => 'ფაილის_განხილვა',
	NS_MEDIAWIKI        => 'მედიავიკი',
	NS_MEDIAWIKI_TALK   => 'მედიავიკის_განხილვა',
	NS_TEMPLATE         => 'თარგი',
	NS_TEMPLATE_TALK    => 'თარგის_განხილვა',
	NS_HELP             => 'დახმარება',
	NS_HELP_TALK        => 'დახმარების_განხილვა',
	NS_CATEGORY         => 'კატეგორია',
	NS_CATEGORY_TALK    => 'კატეგორიის_განხილვა',
];

$namespaceAliases = [
	'მონაწილე'           => NS_USER,
	'მონაწილის_განხილვა'   => NS_USER_TALK,
	'მომხმარებელი_განხილვა' => NS_USER_TALK,
	'სურათი'            => NS_FILE,
	'სურათი_განხილვა'     => NS_FILE_TALK,
	'მედიავიკი_განხილვა'    => NS_MEDIAWIKI_TALK,
	'თარგი_განხილვა'      => NS_TEMPLATE_TALK,
	'დახმარება_განხილვა'    => NS_HELP_TALK,
	'კატეგორია_განხილვა'    => NS_CATEGORY_TALK,
];

/** @phpcs-require-sorted-array */
$specialPageAliases = [
	'Activeusers'               => [ 'აქტიური_მომხმარებლები' ],
	'Allmessages'               => [ 'ყველა_შეტყობინება' ],
	'Allpages'                  => [ 'ყველა_გვერდი' ],
	'Ancientpages'              => [ 'მხცოვანი_გვერდები' ],
	'Badtitle'                  => [ 'ცუდი_სათაური' ],
	'Blankpage'                 => [ 'ცარიელი_გვერდი' ],
	'Block'                     => [ 'დაბლოკვა' ],
	'BlockList'                 => [ 'ბლოკირებების_სია' ],
	'BrokenRedirects'           => [ 'გაწყვეტილი_გადამისამართება' ],
	'Categories'                => [ 'კატეგორიები' ],
	'ChangeEmail'               => [ 'ელ-ფოსტის_შეცვლა' ],
	'ChangePassword'            => [ 'პაროლის_შეცვლა' ],
	'ComparePages'              => [ 'გვერდების_შედარება' ],
	'Confirmemail'              => [ 'ელ-ფოსტის_დადასტურება' ],
	'Contributions'             => [ 'წვლილი' ],
	'CreateAccount'             => [ 'ანგარიშის_შექმნა' ],
	'DoubleRedirects'           => [ 'ორმაგი_გადამისამართება' ],
	'EditWatchlist'             => [ 'კონტროლის_სიის_რედაქტირება' ],
	'Emailuser'                 => [ 'მიწერა_მომხმარებელს' ],
	'Export'                    => [ 'ექსპორტი' ],
	'FileDuplicateSearch'       => [ 'ფაილის_დუბლიკატის_ძიება' ],
	'Import'                    => [ 'იმპორტი' ],
	'LinkSearch'                => [ 'ბმულის_ძიება' ],
	'Listadmins'                => [ 'ადმინისტრატორების_სია' ],
	'Listbots'                  => [ 'ბოტების_სია' ],
	'Listfiles'                 => [ 'ფაილების_სია' ],
	'Listgrouprights'           => [ 'ჯგუფის_უფლებათა_სია' ],
	'Listredirects'             => [ 'გადამისამართებების_სია' ],
	'Listusers'                 => [ 'მომხმარებელთა_სია' ],
	'Lonelypages'               => [ 'ობოლი_გვერდები' ],
	'Longpages'                 => [ 'გრძელი_გვერდები' ],
	'Movepage'                  => [ 'გვერდის_გადატანა' ],
	'Mycontributions'           => [ 'ჩემი_წვლილი' ],
	'MyLanguage'                => [ 'ჩემი_ენა' ],
	'Mypage'                    => [ 'ჩემი_გვერდი' ],
	'Mytalk'                    => [ 'ჩენი_განხილვა' ],
	'Myuploads'                 => [ 'ჩემი_ატვირთვები' ],
	'Newimages'                 => [ 'ახალი_ფაილები' ],
	'Newpages'                  => [ 'ახალი_გვერდები' ],
	'Preferences'               => [ 'კონფიგურაცია' ],
	'Protectedpages'            => [ 'დაცული_გვერდები' ],
	'Protectedtitles'           => [ 'დაცული_სათაურები' ],
	'Randompage'                => [ 'შემთხვევით', 'შემთხვევითი_გვერდი' ],
	'Recentchanges'             => [ 'ბოლოცვლილებები' ],
	'Search'                    => [ 'ძიება' ],
	'Shortpages'                => [ 'მოკლე_გვერდები' ],
	'Specialpages'              => [ 'განსაკუთრებული_გვერდები' ],
	'Statistics'                => [ 'სტატისტიკა' ],
	'Unblock'                   => [ 'ბლოკის_მოხსნა' ],
	'Uncategorizedcategories'   => [ 'უკატეგორიო_კატეგორიები' ],
	'Uncategorizedimages'       => [ 'უკატეგორიო_ფაილები' ],
	'Uncategorizedpages'        => [ 'უკატეგორიო_გვერდები' ],
	'Uncategorizedtemplates'    => [ 'უკატეგორიო_თარგები' ],
	'Undelete'                  => [ 'აღდგენა' ],
	'Unusedcategories'          => [ 'გამოუყენებელი_კატეგორიები' ],
	'Unusedimages'              => [ 'გამოუყენებელი_სურათები' ],
	'Upload'                    => [ 'ატვირთვა' ],
	'Userlogin'                 => [ 'შესვლა' ],
	'Userlogout'                => [ 'გასვლა' ],
	'Userrights'                => [ 'მომხმარებელთა_უფლებები' ],
	'Version'                   => [ 'ვერსია' ],
	'Wantedcategories'          => [ 'მოთხოვნილი_კატეგორიები' ],
	'Wantedfiles'               => [ 'საჭირო_ფაილები' ],
	'Wantedpages'               => [ 'საჭირო_გვერდები' ],
	'Wantedtemplates'           => [ 'საჭირო_თარგები' ],
	'Watchlist'                 => [ 'კონტროლის_სია' ],
	'Withoutinterwiki'          => [ 'ინტერვიკის_გარეშე' ],
];

/** @phpcs-require-sorted-array */
$magicWords = [
	'currentday'                => [ '1', 'მიმდინარე_დღე', 'CURRENTDAY' ],
	'currentday2'               => [ '1', 'მიმდინარე_დღე2', 'CURRENTDAY2' ],
	'currentdayname'            => [ '1', 'მიმდინარე_დღის_სახელი', 'CURRENTDAYNAME' ],
	'currenthour'               => [ '1', 'მიმდინარე_საათი', 'CURRENTHOUR' ],
	'currentmonth'              => [ '1', 'მიმდინარე_თვე', 'მიმდინარე_თვე2', 'CURRENTMONTH', 'CURRENTMONTH2' ],
	'currentmonth1'             => [ '1', 'მიმდინარე_თვე1', 'CURRENTMONTH1' ],
	'currentmonthname'          => [ '1', 'მიმდინარე_თვის_სახელი', 'CURRENTMONTHNAME' ],
	'currentmonthnamegen'       => [ '1', 'მიმდინარე_თვის_სახელის_აბრევიატურა', 'CURRENTMONTHNAMEGEN' ],
	'currenttime'               => [ '1', 'მიმდინარე_დრო', 'CURRENTTIME' ],
	'currentyear'               => [ '1', 'მიმდინარე_წელი', 'CURRENTYEAR' ],
	'fullpagename'              => [ '1', 'გვერდის_სრული_სახელი', 'FULLPAGENAME' ],
	'img_alt'                   => [ '1', 'ალტ=$1', 'alt=$1' ],
	'img_border'                => [ '1', 'საზღვარი', 'border' ],
	'img_bottom'                => [ '1', 'ქვედა', 'bottom' ],
	'img_center'                => [ '1', 'ცენტრი', 'ცენტრში', 'center', 'centre' ],
	'img_left'                  => [ '1', 'მარცხნივ', 'left' ],
	'img_link'                  => [ '1', 'ბმული=$1', 'link=$1' ],
	'img_manualthumb'           => [ '1', 'მინიატიურა=$1', 'მინი=$1', 'thumbnail=$1', 'thumb=$1' ],
	'img_middle'                => [ '1', 'შუა', 'middle' ],
	'img_none'                  => [ '1', 'არა', 'none' ],
	'img_page'                  => [ '1', 'გვერდი=$1', 'გვერდი_$1', 'page=$1', 'page $1' ],
	'img_right'                 => [ '1', 'მარჯვნივ', 'right' ],
	'img_thumbnail'             => [ '1', 'მინი', 'მინიატიურა', 'მინიასლი', 'ცეროდენა', 'thumb', 'thumbnail' ],
	'img_top'                   => [ '1', 'ზედა', 'top' ],
	'img_width'                 => [ '1', '$1პქ', '$1px' ],
	'namespace'                 => [ '1', 'სახელთა_სივრცე', 'NAMESPACE' ],
	'nogallery'                 => [ '0', '__უგალერეო__', '__NOGALLERY__' ],
	'pagename'                  => [ '1', 'გვერდის_სახელი', 'PAGENAME' ],
	'redirect'                  => [ '0', '#გადამისამართება', '#REDIRECT' ],
	'sitename'                  => [ '1', 'საიტის_სახელი', 'SITENAME' ],
	'special'                   => [ '0', 'სპეციალური', 'special' ],
	'subst'                     => [ '0', 'მიდგმ:', 'SUBST:' ],
];

$linkPrefixExtension = true;
$linkTrail = '/^([a-zაბგდევზთიკლმნოპჟრსტუფქღყშჩცძწჭხჯჰ“»]+)(.*)$/sDu';
