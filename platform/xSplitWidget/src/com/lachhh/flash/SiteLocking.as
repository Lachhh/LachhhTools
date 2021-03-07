package com.lachhh.flash {
	import flash.display.DisplayObject;

	/**
	 * @author Simon Lachance
	 */
	public class SiteLocking {				
		static public function isInSites(root:DisplayObject, a:Array):Boolean {
			for (var i:int = 0 ; i < a.length ; i++) {
				if(a[i] != null) {
					if(isInSite(root, a[i])) 
						return true;
				}	
			}
			return false;
		}
		
		static public function isInSite(root:DisplayObject, site:String) : Boolean {
			var siteURL:String ;
		
			if(site == "") {
				var i:int = root.loaderInfo.url.indexOf("file:///");
				return (i != -1);
			} else {
				siteURL = root.loaderInfo.url;
				var domain:String = siteURL.split("/")[2];
				if(domain == null) return false;
				if(domain.indexOf(site) == -1) return false;
				
				/*if(VersionInfo.ignoreExtensionDomain) {
					domain = domain.substring(domain.indexOf(site), domain.length);
					domain = domain.split(".")[0];
				} */
				
				if ((domain.indexOf(site) == (domain.length - site.length))) { 
					return true ;
				} else { 
					return false;
				}
			}
			
		}
	}
}
