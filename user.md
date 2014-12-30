---
layout: page
permalink: /user/
title: User info
tags: [blog]
image:
  feature: Marvin-Gaye-Featured-Image.jpg
---

<ul id="user" class="nav navbar-justified nav-pills"></ul>

<script>
var xhr = new XMLHttpRequest();
xhr.open("GET, "http://api.github.com/v3/repos/AAROC/DevOps/contributors", false);
xhr.send();
console.log(xhr.status);
</script>


<ul id="user" class="nav navbar-justified nav-pills"></ul>
 <script>
 var AAROC = new Gh3.User("AAROC")
, repoTitle = $("h1")
, branchTitle = $("h2")
, branchProperties = $("ul");
//get some repositories of DevOps
var AAROCRepositories = new Gh3.Repositories(AAROC);
AAROCRepositories.fetch({page:5, per_page:5, direction : "desc"},"next", function (err, res) {
if(err) {
throw "outch ..."
}
console.log("Repositories", AAROCRepositories);
});
//get one repository
var DevOps = new Gh3.Repository("DevOps", AAROC);
DevOps.fetch(function (err, res) {
if(err) {
console.log("Error", err.message, res.status)
throw err
}
console.log("Repository : ", DevOps);
repoTitle.html(DevOps.full_name);
DevOps.fetchBranches(function (err, res) {
if(err) {
console.log("Error", err.message, res.status)
throw err
}
console.log("Array of branches : ", DevOps.getBranches());
DevOps.eachBranch(function (branch) {
console.log(branch.name);
})
//and :
var master = DevOps.getBranchByName("master");
branchTitle.html(master.name + " (" + master.sha + ") properties :");
_.each(_.keys(master), function (prop) {
branchProperties.append(
$('<li>').append(prop+" : "+master[prop])
);
});
})
});

</script>
