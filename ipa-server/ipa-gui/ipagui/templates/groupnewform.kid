<div xmlns:py="http://purl.org/kid/ns#"
  class="simpleroster">
  <form action="${action}" name="${name}" method="${method}" class="tableform"
      onsubmit="preSubmit()" >

    <table class="formtable" cellpadding="2" cellspacing="0" border="0">
      <tr>
        <td>
          <input type="submit" class="submitbutton" name="submit" value="Add Group"/>
        </td>
      </tr>
    </table>

<?python
from ipagui.helpers import ipahelper
?>

  <script type="text/javascript" charset="utf-8"
    src="${tg.url('/static/javascript/dynamicedit.js')}"></script>

  <?python searchurl = tg.url('/group/edit_search') ?>

  <script type="text/javascript">
    function doSearch() {
      $('searchresults').update("Searching...");
      new Ajax.Updater('searchresults',
          '${searchurl}',
          {  asynchronous:true,
             parameters: { criteria: $('criteria').value },
             evalScripts: true });
      return false;
    }
  </script>

    <div py:for="field in hidden_fields"
      py:replace="field.display(value_for(field), **params_for(field))" 
      />

    <div class="formsection">Group Details</div>
    <table class="formtable" cellpadding="2" cellspacing="0" border="0">
      <tr>
        <th>
          <label class="fieldlabel" for="${group.cn.field_id}"
            py:content="group.cn.label" />:
        </th>
        <td>
          <span py:replace="group.cn.display(value_for(group.cn))" />
          <span py:if="tg.errors.get('cn')" class="fielderror"
              py:content="tg.errors.get('cn')" />

        </td>
      </tr>

      <tr>
        <th>
          <label class="fieldlabel" for="${group.description.field_id}"
            py:content="group.description.label" />:
        </th>
        <td>
          <span py:replace="group.description.display(value_for(group.description))" />
          <span py:if="tg.errors.get('description')" class="fielderror"
              py:content="tg.errors.get('description')" />

        </td>
      </tr>

      <tr>
        <th>
          <label class="fieldlabel" for="${group.gidnumber.field_id}"
            py:content="group.gidnumber.label" />:
        </th>
        <td>
          Generated by server
        </td>
      </tr>
    </table>

    <div style="clear:both">
      <div class="formsection">Add Members</div>

      <div class="floatlist">
        <div class="floatheader">To Add:</div>
        <div id="newmembers">
        </div>
      </div>

      <div>
        <div id="search">
          <input id="criteria" type="text" name="criteria"
            onkeypress="return enterDoSearch(event);" />
          <input type="button" value="Find"
            onclick="return doSearch();"
          />
        </div>
        <div id="searchresults">
        </div>
      </div>
    </div>

    <table class="formtable" cellpadding="2" cellspacing="0" border="0">
      <tr>
        <td>
          <br />
          <input type="submit" class="submitbutton" name="submit" value="Add Group"/>
        </td>
      </tr>
    </table>

  </form>

  <script type="text/javascript">
    /*
     * This section restores the contents of the add and remove lists
     * dynamically if we have to refresh the page
     */
    if ($('form_dn_to_info_json').value != "") {
      dn_to_info_hash = new Hash($('form_dn_to_info_json').value.evalJSON());
    }
  </script>

  <?python
  dnadds = value.get('dnadd', [])
  if not(isinstance(dnadds,list) or isinstance(dnadds,tuple)):
      dnadds = [dnadds]
  ?>

  <script py:for="dnadd in dnadds">
    <?python
    dnadd_esc = ipahelper.javascript_string_escape(dnadd)
    ?>
    var dn = "${dnadd_esc}";
    var info = dn_to_info_hash[dn];
    var newdiv = addmember(dn, info);
    if (newdiv != null) {
      newdiv.style.display = 'block';
    }
  </script>

</div>
