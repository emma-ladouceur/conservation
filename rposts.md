---
title: "R blog"
layout: category
permalink: /categories/rstats/
taxonomy: Rstats
author_profile: true
header:
  overlay_image: /assets/images/leaf.jpg
---

{% include base_path %}
{% include group-by-array collection=site.posts field="Rstats" %}

{% for category in group_names %}
  {% assign posts = group_items[forloop.index0] %}
  <h2 id="{{ category | slugify }}" class="archive__subtitle">{{ category }}</h2>
  {% for post in posts %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}