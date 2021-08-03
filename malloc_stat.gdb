# __libc_mallinfo() from glibc 2.27 x64

set $av = &main_arena
set $avail = $av->top->mchunk_size & ~7

set $i = 0
while $i < (((((unsigned int) (((((80 * (sizeof (size_t)) / 4)) + (sizeof (size_t)) + ((2 * (sizeof (size_t)) < 16 ? 16 : 2 * (sizeof (size_t))) - 1) < (unsigned long)((((0x20)+((2 * (sizeof (size_t)) < 16 ? 16 : 2 * (sizeof (size_t))) - 1)) & ~((2 * (sizeof (size_t)) < 16 ? 16 : 2 * (sizeof (size_t))) - 1)))) ? (unsigned long)((((0x20)+((2 * (sizeof (size_t)) < 16 ? 16 : 2 * (sizeof (size_t))) - 1)) & ~((2 * (sizeof (size_t)) < 16 ? 16 : 2 * (sizeof (size_t))) - 1))) : (((80 * (sizeof (size_t)) / 4)) + (sizeof (size_t)) + ((2 * (sizeof (size_t)) < 16 ? 16 : 2 * (sizeof (size_t))) - 1)) & ~((2 * (sizeof (size_t)) < 16 ? 16 : 2 * (sizeof (size_t))) - 1)))) >> ((sizeof (size_t)) == 8 ? 4 : 3)) - 2) + 1)
  set $p = (($av)->fastbinsY[$i])
  while $p != 0
    set $avail = $avail + ((($p)->mchunk_size) & ~((0x1 | 0x2 | 0x4)))
    $p = $p->fd
  end
  set $i = $i + 1
end

set $i = 1
while $i < 128
  set $b = (mbinptr) (((char *) &(($av)->bins[(($i) - 1) * 2])) - 0x10)
  set $p = $b->bk
  while $p != $b
    set $avail = $avail + ((($p)->mchunk_size) & ~((0x1 | 0x2 | 0x4)))
    set $p = $p->bk
  end
  set $i = $i + 1
end

p $av->system_mem
p $av->system_mem - $avail
