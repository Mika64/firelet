
<style>
img#help { float: right; }
div#help_ovr {
    background-color:#fff;
    display:none;
    width: 70em;
    padding:15px;
    text-align:left;
    border:2px solid #333;
    opacity:0.98;
    -moz-border-radius:6px;
    -webkit-border-radius:6px;
    -moz-box-shadow: 0 0 50px #ccc;
    -webkit-box-shadow: 0 0 50px #ccc;
}
#triggers img {
    border:0;
    cursor:pointer;
    margin-left:11px;
}

/* Form validation error message */

.error {
    z-index: 30055;
    height:15px;
    background-color: #eeeeff;
    border:1px solid #000;
    font-size:11px;
    color:#000;
    padding:3px 10px;
    margin-left:20px;


    /* CSS3 spicing for mozilla and webkit */
    -moz-border-radius:4px;
    -webkit-border-radius:4px;
    -moz-border-radius-bottomleft:0;
    -moz-border-radius-topleft:0;
    -webkit-border-bottom-left-radius:0;
    -webkit-border-top-left-radius:0;

    -moz-box-shadow:0 0 6px #ddd;
    -webkit-box-shadow:0 0 6px #ddd;
}
</style>

<img id="help" src="static/help.png" rel="div#help_ovr" title="Help">
<div id="help_ovr">
    <h4>Contextual help: Manage</h4>
    <p>TODO</p>
    <p>Here some nice Lorem ipsum:</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    <br/>
    <p>Press ESC to close this window</p>
</div>


<table id="items">
    <thead>
        <tr><th></th><th>Name</th><th>Iface</th><th>IP Address</th><th>Role</th></tr>
    </thead>
% for rid, host in hosts:
    <tr id="{{rid}}">
    <td class="hea">
        <img src="/static/delete.png" title="Delete host" class="delete">
    </td>
    % for item in host:
    <td>{{item}}</td>
    % end
    </tr>
% end
</table>

<p><img src="static/new.png" rel="#new_form"/> New host</p>


<!-- New item form -->
<div id="new_form">
    <form id="new_form">

       <fieldset>
          <h3>New host creation</h3>

          <p> Enter bad values and then press the submit button. </p>

          <p>
             <label>hostname *</label>
             <input type="text" name="hostname" pattern="[a-zA-Z0-9_]{2,512}" maxlength="30" />
          </p>
          <p>
             <label>interface *</label>
             <input type="text" name="iface" pattern="[a-zA-Z0-9]{2,32}" maxlength="30" />
          </p>
          <p>
             <label>IP address *</label>
             <input type="text" name="ip_addr" pattern="[0-9.:]{7,}" maxlength="30" />
          </p>


          <p>
            <label>Local firewall</label>
            <input type="checkbox" />
          </p>
          <p>
            <label>Network firewall</label>
            <input type="checkbox" />
          </p>

          <button type="submit">Submit form</button>
          <button type="reset">Reset</button>
       </fieldset>
    </form>
    <p>Enter and Esc keys are supported.</p>
</div>



<script>
$(function() {
$("table#items tr td img[title]").tooltip({
    tip: '.tooltip',
    effect: 'fade',
    fadeOutSpeed: 100,
    predelay: 800,
    position: "bottom right",
    offset: [15, 15]
});

$("table#items tr td img").fadeTo("fast", 0.6);

$("table#items tr td img").hover(function() {
  $(this).fadeTo("fast", 1);
}, function() {
  $(this).fadeTo("fast", 0.6);
});

$(function() {
    $('img.delete').click(function() {
        td = this.parentElement.parentElement;
        $.post("hosts", { action: 'delete', rid: td.id},
            function(data){
                $('div.tabpane div').load('/hosts');
            });
    });
});


var over = $("img[rel]").overlay({
        mask: {
            loadSpeed: 200,
            opacity: 0.9
        },
        closeOnClick: false
});


// initialize validator for new_form

$("form#new_form").validator().submit(function(e) {
    var form = $(this);
    // client-side validation OK
    if (!e.isDefaultPrevented()) {
    ff = $('form#new_form').serializeArray();

    $.post("hosts_new", ff,
        function(json){
            if (json.ok === true) {
                over.eq(0).overlay().close();
            } else {
                form.data("validator").invalidate(json);
            }
        }, "json"
    );

        e.preventDefault();     // prevent default form submission logic
    }
});



    // Help overlay
    $("img#help[rel]").overlay({ mask: {loadSpeed: 200, opacity: 0.9, }, });
});
</script>

