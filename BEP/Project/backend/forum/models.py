from django.db import models
from django.conf import settings
from django.utils.translation import ugettext_lazy as _
from django.contrib.contenttypes.models import ContentType



class Forum(models.Model):

    model = models.ForeignKey(ContentType, related_name="forum_model", on_delete=models.PROTECT)
    parent_id = models.PositiveIntegerField()
    parent_model = models.ForeignKey(ContentType, related_name="forum_parent_model", on_delete=models.PROTECT)

    creator = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="forum_creator", on_delete=models.CASCADE)
    last_modifier = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="forum_last_modifier", on_delete=models.CASCADE)

    created_date = models.DateTimeField(_("created date"), auto_now_add=True)
    modified_date = models.DateTimeField(_("modified date"), auto_now=True)

    is_modified = models.BooleanField(_("modified"), blank=True, default=False)
    is_deleted = models.BooleanField(_("deleted"), blank=True, default=False)
    is_hidden = models.BooleanField(_("hidden"), blank=True, default=False)

    name = models.CharField(_("forum name"), max_length=255)

    # -------------------------------------------------------------------------

    class Meta:
        app_label = "backend"
        db_table = "forum"
        get_latest_by = "created_date"
        ordering = (
            "name",
            "created_date",
        )

    # -------------------------------------------------------------------------

    def __str__(self):
        return self.name
