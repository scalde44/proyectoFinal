<%-- 
    Document   : paginator
    Created on : 3/06/2019, 09:26:52 PM
    Author     : steve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Pagination</title>
        <script type="text/javascript" src="pager.js"></script>
        <style type="text/css">
            .pg-normal {
                color: black;
                font-weight: normal;
                text-decoration: none;
                cursor: pointer;
                font-family:    'Lucida Grande',Verdana,Arial,Sans-Serif;
                font-size:10px
            }
            .pg-selected {
                color: black;
                font-weight: bold;
                text-decoration: underline;
                cursor: pointer;
                font-family:    'Lucida Grande',Verdana,Arial,Sans-Serif;
                font-size:10px
            }
        </style>
    </head>
    <body>


        <form action="" method="get">
            <table align="center" id="results">
                <tr>
                    <th></th>
                    <th>Field</th>

                </tr>
                <tr>
                    <td>1</td>
                    <td><input type="text" name="field-name" value="rec1"></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td><input type="text" name="field-name" value="rec2"></td>

                </tr>
                <tr>
                    <td>3</td>
                    <td><input type="text" name="field-name" value="rec3"></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td><input type="text" name="field-name" value="rec4"></td>

                </tr>
                <tr>
                    <td>5</td>
                    <td><input type="text" name="field-name" value="rec5"></td>
                </tr>
                <tr>
                    <td>6</td>
                    <td><input type="text" name="field-name" value="rec6"></td>

                </tr>
                <tr>
                    <td>7</td>
                    <td><input type="text" name="field-name" value="rec7"></td>
                </tr>
                <tr>
                    <td>8</td>
                    <td><input type="text" name="field-name" value="rec8"></td>

                </tr>
                <tr>
                    <td>9</td>
                    <td><input type="text" name="field-name" value="rec9"></td>
                </tr>
                <tr>
                    <td>10</td>
                    <td><input type="text" name="field-name" value="rec10"></td>

                </tr>
            </table>
            <div id="pageNavPosition"></div>
        </form>

        <script type="text/javascript">
            var pager = new Pager('results', 3);
            pager.init();
            pager.showPageNav('pager', 'pageNavPosition');
            pager.showPage(1);

        </script>

    </div>
</body>
</html>
