document.querySelectorAll('#year').forEach(element => { element.textContent = new Date().getFullYear(); });

document.querySelectorAll('[data-screenshot-gallery]').forEach((gallery, galleryIndex) => {
  const panels = Array.from(gallery.querySelectorAll('[data-device]'))
    .filter(panel => panel.querySelector('img'));
  if (panels.length < 2) return;

  const tabs = document.createElement('div');
  tabs.className = 'screenshot-tabs';
  tabs.setAttribute('role', 'tablist');
  tabs.setAttribute('aria-label', 'Screenshot device');
  const buttons = panels.map((panel, index) => {
    const button = document.createElement('button');
    button.type = 'button';
    button.textContent = panel.dataset.device;
    button.id = `screenshot-tab-${galleryIndex}-${index}`;
    panel.id ||= `screenshot-panel-${galleryIndex}-${index}`;
    button.setAttribute('role', 'tab');
    button.setAttribute('aria-controls', panel.id);
    panel.setAttribute('role', 'tabpanel');
    panel.setAttribute('aria-labelledby', button.id);
    panel.tabIndex = 0;
    button.addEventListener('click', () => select(index));
    button.addEventListener('keydown', event => {
      let next;
      if (event.key === 'ArrowRight') next = (index + 1) % panels.length;
      if (event.key === 'ArrowLeft') next = (index + panels.length - 1) % panels.length;
      if (event.key === 'Home') next = 0;
      if (event.key === 'End') next = panels.length - 1;
      if (next === undefined) return;
      event.preventDefault();
      select(next);
      buttons[next].focus();
    });
    tabs.append(button);
    return button;
  });

  function select(selected) {
    panels.forEach((panel, index) => {
      panel.hidden = index !== selected;
      buttons[index].setAttribute('aria-selected', String(index === selected));
      buttons[index].tabIndex = index === selected ? 0 : -1;
    });
  }

  gallery.prepend(tabs);
  select(0);
});
