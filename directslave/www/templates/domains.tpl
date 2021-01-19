<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/favicon.ico">

    <title>{{.Product}}</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/dashboard.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">{{.Product}}</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">

          <ul class="nav navbar-nav navbar-right">
            <li><a href="/dashboard/domains">Domains</a></li>
            <li><a href="/dashboard/users">Manage Users</a></li>
            <li><a href="/dashboard/logs">Log Files</a></li>
            <li><a href="/logout">Logout</a></li>
          </ul>
          <form class="navbar-form navbar-right"  action="/dashboard/domains" method="post">
            <input type="text" name="search" class="form-control" placeholder="Search domain...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
		      <ul class="nav nav-sidebar">
            <li class="active"><a href="/dashboard/domains">Domains</a></li>
            <li><a href="/dashboard/users">Manage Users</a></li>
            <li><a href="/dashboard/logs">Log Files</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="/logout">Logout</a></li>
          </ul>
        </div>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h2 class="sub-header">
            <span>Domains </span> 
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="/dashboard/domains/add">
              <span style="font-size: 18pt; color: #39A14F; align-content: right;" class="glyphicon glyphicon-plus"></span>
            </a>
            </h2>
          
          {{ if .ErrorMessage}} <div> {{.ErrorMessage}} </div> {{end}}
          {{ if .Pager }}
          <form action="/dashboard/domains" id="pageForm" method="get">
            <div class="form-group">
              <label for="sel1">Select page (50 entries / one):</label>
              <select class="form-control" id="sel1" name="page" onchange="this.form.submit()">
                {{ .Pager }}
              </select>
            </div>
          </form>
          {{end}}
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Domain</th>
                  <th>Master</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>

              {{ if .CustomRow }} 
          
              <form action="/dashboard/domains/save" method="post">
                <tr>
                <td><input name="CustomName"  type="text" value="{{ .CustomName }}"  class="form-control"></td>
                <td><input name="CustomValue" type="text" value="{{ .CustomValue }}" class="form-control"></td>
                <td>
                    <input type="hidden" name="CustomAction" value="{{ .CustomAction }}">
                    <button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-saved"></span> Save</button>
                </td>
                </tr>
              </form> 

              {{else}}

              {{ if .Domains }}
              {{ range .Domains }}
          
                <tr>
                  <td>{{ .Name }}</td>
                  <td>{{ .Master }}</td>
                  <td>
                    <a href="/dashboard/domains/edit?domain={{ .Name }}" style="font-size: 18px;" class="glyphicon glyphicon-edit"></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="/dashboard/domains/remove?domain={{ .Name }}" style="font-size: 18px;" class="glyphicon glyphicon-remove"></a>
                  </td>
                </tr> 
          
              {{end}} 
              {{else}} 
          
                  <tr>
                  <td colspan="3">No active domains.</td>
                  </tr>
          
              {{end}} 
              {{end}} 
              
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/js/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="/js/jquery.min.js"><\/script>')</script>
    <script src="/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/js/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
